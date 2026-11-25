package com.forgetrace.service;

import com.forgetrace.config.DisplayFormatter;
import com.forgetrace.dto.response.OrderView;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Quotation;
import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.QuotationStatus;
import com.forgetrace.enums.RfqStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.QuotationExpiredException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.OrderMapper;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.QuotationRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.util.ReferenceNumberGenerator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

/**
 * Accepting a quotation creates exactly ONE production order (tests FT-019, FT-020):
 * - the quotation row is LOCKED (SELECT ... FOR UPDATE) so two clicks are processed one after the other;
 * - status, expiry and RFQ state are checked after the lock;
 * - unique constraints on production_orders (quotation and RFQ) are the final safety net.
 * Everything happens in one transaction: either all of it is saved or none of it.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class OrderService {

    private static final int PAGE_SIZE = 10;

    private final ProductionOrderRepository orderRepository;
    private final QuotationRepository quotationRepository;
    private final ProductionService productionService;
    private final NotificationService notificationService;
    private final ReferenceNumberGenerator referenceNumbers;
    private final DisplayFormatter formatter;
    private final OrderMapper mapper;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    @Transactional
    public ProductionOrder acceptQuotation(Long quotationId) {
        accessGuard.requireRole(RoleName.BUYER);
        Long userId = currentUserService.requireUserId();

        // 1. Lock the quotation row - a second request waits here until this transaction ends
        Quotation quotation = quotationRepository.findByIdForUpdate(quotationId)
                .orElseThrow(() -> new ResourceNotFoundException("Quotation", quotationId));
        Rfq rfq = quotation.getRfq();
        accessGuard.requireMembership(rfq.getBuyerOrganization().getId());

        // 2. Re-check everything AFTER the lock
        Instant now = Instant.now();
        if (quotation.getStatus() != QuotationStatus.SUBMITTED) {
            throw new BusinessRuleException("This quotation can no longer be accepted (it is "
                    + quotation.getStatus().getLabel().toLowerCase() + ").");
        }
        if (quotation.isExpired(now)) {
            throw new QuotationExpiredException(quotation.getQuotationNumber());
        }
        if (rfq.getStatus() != RfqStatus.OPEN && rfq.getStatus() != RfqStatus.CLOSED) {
            throw new BusinessRuleException("This RFQ is already " + rfq.getStatus().getLabel().toLowerCase() + ".");
        }
        if (orderRepository.existsByRfq_Id(rfq.getId())) {
            throw new BusinessRuleException("An order already exists for this RFQ.");
        }

        // 3. Update the quotation, the competing quotations and the RFQ
        quotation.setStatus(QuotationStatus.ACCEPTED);
        rfq.setStatus(RfqStatus.AWARDED);
        for (Quotation other : quotationRepository.findByRfq_IdAndStatus(rfq.getId(), QuotationStatus.SUBMITTED)) {
            if (!other.getId().equals(quotation.getId())) {
                other.setStatus(QuotationStatus.REJECTED);
                notificationService.notifyOrganization(other.getManufacturerOrganization().getId(),
                        "Quotation not selected", "The buyer chose another offer for " + rfq.getTitle() + ".",
                        "/manufacturer/quotations");
            }
        }

        // 4. Create the order
        ProductionOrder order = new ProductionOrder();
        order.setOrderNumber(referenceNumbers.next("ORD"));
        order.setAcceptedQuotation(quotation);
        order.setRfq(rfq);
        order.setBuyerOrganization(rfq.getBuyerOrganization());
        order.setManufacturerOrganization(quotation.getManufacturerOrganization());
        order.setQuantity(rfq.getQuantity());
        order.setTotalAmount(quotation.getTotalAmount());
        order.setCurrency(quotation.getCurrency());
        order.setExpectedCompletion(LocalDate.now(ZoneId.of(displayZone)).plusDays(quotation.getLeadTimeDays()));
        order.setStatus(OrderStatus.CONFIRMED);
        try {
            orderRepository.saveAndFlush(order);
        } catch (DataIntegrityViolationException ex) {
            // A parallel request accepted another quotation on the same RFQ first
            throw new BusinessRuleException("An order was just created for this RFQ by another request.");
        }

        productionService.recordEvent(order, null, OrderStatus.CONFIRMED, userId,
                "Quotation " + quotation.getQuotationNumber() + " accepted");

        notificationService.notifyOrganization(order.getManufacturerOrganization().getId(),
                "New order " + order.getOrderNumber(),
                "Your quotation " + quotation.getQuotationNumber() + " for " + rfq.getTitle() + " was accepted ("
                        + formatter.money(order.getTotalAmount(), order.getCurrency()) + "). Book machine time to schedule it.",
                "/manufacturer/orders/" + order.getId());
        auditService.record(userId, "ORDER_CREATED", "ProductionOrder", order.getId(),
                order.getOrderNumber() + " from " + quotation.getQuotationNumber());
        log.info("Order {} created from quotation {}", order.getOrderNumber(), quotation.getQuotationNumber());
        return order;
    }

    // ================= Reading =================

    @Transactional(readOnly = true)
    public Page<OrderView> listForBuyer(int page) {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        return orderRepository.findByBuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(Math.max(page, 0), PAGE_SIZE))
                .map(mapper::toView);
    }

    @Transactional(readOnly = true)
    public Page<OrderView> listForManufacturer(int page) {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        Long orgId = currentUserService.requireOrganizationId();
        return orderRepository.findByManufacturerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(Math.max(page, 0), PAGE_SIZE))
                .map(mapper::toView);
    }

    @Transactional(readOnly = true)
    public OrderView getForBuyer(Long orderId) {
        accessGuard.requireRole(RoleName.BUYER);
        ProductionOrder order = load(orderId);
        requireOwnOrganization(order.getBuyerOrganization().getId(), orderId);
        return mapper.toView(order);
    }

    @Transactional(readOnly = true)
    public OrderView getForManufacturer(Long orderId) {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        ProductionOrder order = load(orderId);
        requireOwnOrganization(order.getManufacturerOrganization().getId(), orderId);
        return mapper.toView(order);
    }

    private void requireOwnOrganization(Long organizationId, Long orderId) {
        if (!organizationId.equals(currentUserService.requireOrganizationId())) {
            throw new ResourceNotFoundException("Order", orderId);
        }
    }

    private ProductionOrder load(Long orderId) {
        return orderRepository.findWithDetailsById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
    }
}