package com.forgetrace.service;

import com.forgetrace.dto.request.BatchCreateRequest;
import com.forgetrace.dto.response.BatchView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.User;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.InvalidOrderTransitionException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.notification.NotificationMessage;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.util.ReferenceNumberGenerator;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class BatchService {

    private static final Set<OrderStatus> BATCHABLE_ORDER_STATUSES = EnumSet.of(OrderStatus.IN_PRODUCTION, OrderStatus.QUALITY_CHECK);
    private static final Set<BatchStatus> MANUFACTURER_TARGETS = EnumSet.of(BatchStatus.IN_PROGRESS, BatchStatus.AWAITING_INSPECTION);

    private final BatchRepository batchRepository;
    private final ProductionOrderRepository orderRepository;
    private final ProductPassportRepository passportRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;
    private final ReferenceNumberGenerator referenceNumbers;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    public record OrderOption(Long id, String orderNumber, String title, BigDecimal remaining, String unit) {
    }

    @Transactional(readOnly = true)
    public List<OrderOption> batchableOrders() {
        Long orgId = requireManufacturerOrganization();
        return orderRepository.findByManufacturerOrganization_IdAndStatusInOrderByExpectedCompletionAsc(orgId, BATCHABLE_ORDER_STATUSES)
                .stream()
                .map(o -> new OrderOption(o.getId(), o.getOrderNumber(), o.getRfq().getTitle(), remaining(o), o.getRfq().getQuantityUnit()))
                .filter(o -> o.remaining().signum() > 0)
                .toList();
    }

    @Transactional
    public Batch create(BatchCreateRequest form) {
        Long orgId = requireManufacturerOrganization();
        ProductionOrder order = orderRepository.findWithDetailsById(form.getOrderId())
                .filter(o -> o.getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", form.getOrderId()));
        if (!BATCHABLE_ORDER_STATUSES.contains(order.getStatus())) {
            throw new BusinessRuleException("Batches can only be created while the order is in production or quality check.");
        }
        if (form.getManufactureDate().isAfter(LocalDate.now(ZoneId.of(displayZone)))) {
            throw new BusinessRuleException("Manufacture date cannot be in the future.");
        }
        BigDecimal remaining = remaining(order);
        if (form.getQuantity().compareTo(remaining) > 0) {
            throw new BusinessRuleException("Batch quantity exceeds the order. Remaining for this order: "
                    + remaining.stripTrailingZeros().toPlainString() + " " + order.getRfq().getQuantityUnit() + ".");
        }

        Batch batch = new Batch();
        batch.setProductionOrder(order);
        batch.setBatchNumber(referenceNumbers.next("BAT"));
        batch.setQuantity(form.getQuantity());
        batch.setManufactureDate(form.getManufactureDate());
        batch.setStatus(BatchStatus.CREATED);
        batchRepository.save(batch);
        auditService.record(currentUserService.requireUserId(), "BATCH_CREATED", "Batch", batch.getId(),
                batch.getBatchNumber() + " for " + order.getOrderNumber());
        return batch;
    }

    @Transactional
    public void advance(Long batchId, BatchStatus target) {
        Long orgId = requireManufacturerOrganization();
        Batch batch = batchRepository.findById(batchId)
                .filter(b -> b.getProductionOrder().getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Batch", batchId));
        if (!MANUFACTURER_TARGETS.contains(target)) {
            throw new InvalidOrderTransitionException("Manufacturers cannot set a batch to '" + target.getLabel() + "'.");
        }
        if (!batch.getStatus().canTransitionTo(target)) {
            throw new InvalidOrderTransitionException("A batch cannot move from '" + batch.getStatus().getLabel()
                    + "' to '" + target.getLabel() + "'.");
        }
        batch.setStatus(target);
        if (target == BatchStatus.AWAITING_INSPECTION) {
            notifyInspectors(batch);
        }
        auditService.record(currentUserService.requireUserId(), "BATCH_STATUS_CHANGED", "Batch", batchId, target.name());
    }

    @Transactional(readOnly = true)
    public List<BatchView> listMine(Long orderIdFilter) {
        Long orgId = requireManufacturerOrganization();
        return batchRepository.findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(orgId).stream()
                .filter(b -> orderIdFilter == null || b.getProductionOrder().getId().equals(orderIdFilter))
                .map(this::toView)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<BatchView> inspectionQueue() {
        accessGuard.requireRole(RoleName.QUALITY_INSPECTOR, RoleName.ADMIN);
        return batchRepository.findByStatusInOrderByUpdatedAtAsc(EnumSet.of(BatchStatus.AWAITING_INSPECTION, BatchStatus.ON_HOLD))
                .stream().map(this::toView).toList();
    }

    @Transactional(readOnly = true)
    public List<BatchView> passportsForBuyer() {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        return passportRepository.findByBatch_ProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(orgId).stream()
                .map(p -> toView(p.getBatch()))
                .toList();
    }

    @Transactional(readOnly = true)
    public BatchView view(Batch batch) {
        return toView(batch);
    }

    BatchView toView(Batch b) {
        ProductionOrder o = b.getProductionOrder();
        UUID token = passportRepository.findByBatch_Id(b.getId()).map(p -> p.getPublicToken()).orElse(null);
        return new BatchView(b.getId(), b.getBatchNumber(), o.getId(), o.getOrderNumber(), o.getRfq().getTitle(),
                o.getRfq().getProcess().getProcessName(), o.getRfq().getMaterial().getMaterialName(),
                o.getManufacturerOrganization().getDisplayName(), o.getBuyerOrganization().getDisplayName(),
                b.getQuantity(), o.getRfq().getQuantityUnit(), b.getManufactureDate(), b.getStatus(), b.getUpdatedAt(), token);
    }

    private BigDecimal remaining(ProductionOrder order) {
        BigDecimal used = batchRepository.sumQuantityForOrder(order.getId(), BatchStatus.REJECTED);
        return order.getQuantity().subtract(used == null ? BigDecimal.ZERO : used);
    }

    private void notifyInspectors(Batch batch) {
        String title = "Batch ready for inspection: " + batch.getBatchNumber();
        String body = batch.getProductionOrder().getManufacturerOrganization().getDisplayName() + " · "
                + batch.getQuantity().stripTrailingZeros().toPlainString() + " units for order "
                + batch.getProductionOrder().getOrderNumber();
        for (User inspector : userRepository.findByRoles_RoleName(RoleName.QUALITY_INSPECTOR)) {
            notificationService.send(new NotificationMessage(inspector.getId(), inspector.getEmail(), inspector.getFullName(),
                    title, body, "/inspector/batches/" + batch.getId()));
        }
    }

    private Long requireManufacturerOrganization() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }
}