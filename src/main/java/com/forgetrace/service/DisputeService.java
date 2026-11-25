package com.forgetrace.service;

import com.forgetrace.dto.request.DisputeRequest;
import com.forgetrace.entity.Dispute;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.User;
import com.forgetrace.enums.DisputeStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.notification.NotificationMessage;
import com.forgetrace.repository.DisputeRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class DisputeService {

    private static final Set<DisputeStatus> ACTIVE = EnumSet.of(DisputeStatus.OPEN, DisputeStatus.UNDER_REVIEW);

    private final DisputeRepository disputeRepository;
    private final ProductionOrderRepository orderRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    public record OrderOption(Long id, String orderNumber, String title) {
    }

    public record DisputeView(Long id, Long orderId, String orderNumber, String buyerName, String manufacturerName,
                              String openedBy, String reason, String description, DisputeStatus status,
                              String resolution, String resolvedBy, Instant resolvedAt, Instant createdAt) {
        public boolean isActive() {
            return status == DisputeStatus.OPEN || status == DisputeStatus.UNDER_REVIEW;
        }
    }

    public static List<DisputeStatus> nextStatuses(DisputeStatus current) {
        return switch (current) {
            case OPEN -> List.of(DisputeStatus.UNDER_REVIEW, DisputeStatus.RESOLVED, DisputeStatus.REJECTED);
            case UNDER_REVIEW -> List.of(DisputeStatus.RESOLVED, DisputeStatus.REJECTED);
            case RESOLVED, REJECTED -> List.of();
        };
    }

    @Transactional(readOnly = true)
    public List<OrderOption> orderOptions() {
        Long orgId = requireBuyer();
        return orderRepository.findByBuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(0, 100)).getContent().stream()
                .filter(o -> o.getStatus() != OrderStatus.CANCELLED)
                .map(o -> new OrderOption(o.getId(), o.getOrderNumber(), o.getRfq().getTitle()))
                .toList();
    }

    @Transactional
    public Dispute open(DisputeRequest form) {
        Long orgId = requireBuyer();
        Long userId = currentUserService.requireUserId();
        ProductionOrder order = orderRepository.findWithDetailsById(form.getOrderId())
                .filter(o -> o.getBuyerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", form.getOrderId()));
        boolean alreadyOpen = disputeRepository.findByProductionOrder_IdOrderByCreatedAtDesc(order.getId()).stream()
                .anyMatch(d -> ACTIVE.contains(d.getStatus()));
        if (alreadyOpen) {
            throw new BusinessRuleException("This order already has an open dispute.");
        }
        Dispute dispute = new Dispute();
        dispute.setProductionOrder(order);
        dispute.setOpenedBy(userRepository.getReferenceById(userId));
        dispute.setReason(form.getReason().trim());
        dispute.setDescription(form.getDescription() == null || form.getDescription().isBlank() ? null : form.getDescription().trim());
        dispute.setStatus(DisputeStatus.OPEN);
        disputeRepository.save(dispute);

        notificationService.notifyOrganization(order.getManufacturerOrganization().getId(),
                "Dispute opened on " + order.getOrderNumber(), dispute.getReason(), "/manufacturer/orders/" + order.getId());
        notifyAdmins("New dispute on " + order.getOrderNumber(), dispute.getReason(), "/admin/disputes/" + dispute.getId());
        auditService.record(userId, "DISPUTE_OPENED", "Dispute", dispute.getId(), order.getOrderNumber());
        return dispute;
    }

    @Transactional(readOnly = true)
    public Page<DisputeView> listForBuyer(int page) {
        Long orgId = requireBuyer();
        return disputeRepository.findByProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(orgId,
                PageRequest.of(Math.max(page, 0), 15)).map(this::toView);
    }

    @Transactional(readOnly = true)
    public Page<DisputeView> listAll(DisputeStatus status, int page) {
        requireAdmin();
        PageRequest pageable = PageRequest.of(Math.max(page, 0), 20, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Dispute> result = status == null ? disputeRepository.findAll(pageable)
                : disputeRepository.findByStatusOrderByCreatedAtDesc(status, PageRequest.of(Math.max(page, 0), 20));
        return result.map(this::toView);
    }

    @Transactional(readOnly = true)
    public DisputeView detail(Long id) {
        requireAdmin();
        return disputeRepository.findById(id).map(this::toView).orElseThrow(() -> new ResourceNotFoundException("Dispute", id));
    }

    @Transactional
    public void update(Long id, DisputeStatus target, String resolution) {
        requireAdmin();
        Long adminId = currentUserService.requireUserId();
        Dispute dispute = disputeRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Dispute", id));
        if (target == null || !nextStatuses(dispute.getStatus()).contains(target)) {
            throw new BusinessRuleException("A dispute cannot move from '" + dispute.getStatus().getLabel() + "' to that status.");
        }
        boolean closing = target == DisputeStatus.RESOLVED || target == DisputeStatus.REJECTED;
        if (closing && (resolution == null || resolution.isBlank())) {
            throw new BusinessRuleException("Write the resolution so both parties know the outcome.");
        }
        dispute.setStatus(target);
        if (closing) {
            dispute.setResolution(resolution.trim());
            dispute.setResolvedBy(userRepository.getReferenceById(adminId));
            dispute.setResolvedAt(Instant.now());
        }
        ProductionOrder order = dispute.getProductionOrder();
        String body = "Dispute on " + order.getOrderNumber() + " is now '" + target.getLabel() + "'."
                + (closing ? " Resolution: " + resolution.trim() : "");
        notificationService.notifyOrganization(order.getBuyerOrganization().getId(), "Dispute update", body, "/buyer/disputes");
        notificationService.notifyOrganization(order.getManufacturerOrganization().getId(), "Dispute update", body,
                "/manufacturer/orders/" + order.getId());
        auditService.record(adminId, "DISPUTE_" + target.name(), "Dispute", id, closing ? resolution.trim() : null);
    }

    private DisputeView toView(Dispute d) {
        ProductionOrder o = d.getProductionOrder();
        return new DisputeView(d.getId(), o.getId(), o.getOrderNumber(), o.getBuyerOrganization().getDisplayName(),
                o.getManufacturerOrganization().getDisplayName(), d.getOpenedBy().getFullName(), d.getReason(),
                d.getDescription(), d.getStatus(), d.getResolution(),
                d.getResolvedBy() == null ? null : d.getResolvedBy().getFullName(), d.getResolvedAt(), d.getCreatedAt());
    }

    private void notifyAdmins(String title, String body, String link) {
        for (User admin : userRepository.findByRoles_RoleName(RoleName.ADMIN)) {
            notificationService.send(new NotificationMessage(admin.getId(), admin.getEmail(), admin.getFullName(), title, body, link));
        }
    }

    private Long requireBuyer() {
        accessGuard.requireRole(RoleName.BUYER);
        return currentUserService.requireOrganizationId();
    }

    private void requireAdmin() {
        accessGuard.requireRole(RoleName.ADMIN);
    }
}