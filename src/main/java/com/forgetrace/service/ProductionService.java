package com.forgetrace.service;

import com.forgetrace.dto.response.OrderTimelineItem;
import com.forgetrace.dto.response.OrderView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.MachineReservation;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.ProductionOrderEvent;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.ReservationStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.InvalidOrderTransitionException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.OrderMapper;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.MachineReservationRepository;
import com.forgetrace.repository.ProductionOrderEventRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.EnumSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Order status changes. Every change:
 * 1. must be allowed by OrderStatus.allowedNext()  (test FT-026),
 * 2. must be allowed for the user's role,
 * 3. must meet its business precondition (e.g. booked machine time before "Scheduled"),
 * 4. is recorded as a ProductionOrderEvent (the timeline) and notified to the other party.
 */
@Service
@RequiredArgsConstructor
public class ProductionService {

    /** Statuses a manufacturer may set by hand. SHIPPED/DELIVERED come from shipments (Step 9). */
    public static final Set<OrderStatus> MANUFACTURER_STATUSES = EnumSet.of(
            OrderStatus.SCHEDULED, OrderStatus.IN_PRODUCTION, OrderStatus.QUALITY_CHECK,
            OrderStatus.READY_TO_SHIP, OrderStatus.ON_HOLD, OrderStatus.CANCELLED);

    /** Statuses a buyer may set: cancel before production, or confirm completion after delivery. */
    public static final Set<OrderStatus> BUYER_STATUSES = EnumSet.of(OrderStatus.CANCELLED, OrderStatus.COMPLETED);

    /** Columns of the production board, in order. */
    public static final List<OrderStatus> BOARD_COLUMNS = List.of(
            OrderStatus.CONFIRMED, OrderStatus.SCHEDULED, OrderStatus.IN_PRODUCTION,
            OrderStatus.QUALITY_CHECK, OrderStatus.READY_TO_SHIP, OrderStatus.ON_HOLD);

    private final ProductionOrderRepository orderRepository;
    private final ProductionOrderEventRepository eventRepository;
    private final MachineReservationRepository reservationRepository;
    private final BatchRepository batchRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;
    private final OrderMapper mapper;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    // ================= Status changes =================

    @Transactional
    public void changeStatusAsManufacturer(Long orderId, OrderStatus target, String notes) {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        Long orgId = currentUserService.requireOrganizationId();
        ProductionOrder order = load(orderId);
        if (!order.getManufacturerOrganization().getId().equals(orgId)) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        if (!MANUFACTURER_STATUSES.contains(target)) {
            throw new InvalidOrderTransitionException("Manufacturers cannot set an order to '" + target.getLabel() + "'.");
        }
        checkPreconditions(order, target);
        applyTransition(order, target, notes, currentUserService.requireUserId(),
                order.getBuyerOrganization().getId(), "/buyer/orders/" + orderId);
    }

    @Transactional
    public void changeStatusAsBuyer(Long orderId, OrderStatus target, String notes) {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        ProductionOrder order = load(orderId);
        if (!order.getBuyerOrganization().getId().equals(orgId)) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        if (!BUYER_STATUSES.contains(target)) {
            throw new InvalidOrderTransitionException("Buyers cannot set an order to '" + target.getLabel() + "'.");
        }
        if (target == OrderStatus.CANCELLED && order.getStatus() != OrderStatus.CONFIRMED) {
            throw new InvalidOrderTransitionException("An order can only be cancelled by the buyer before production is scheduled.");
        }
        applyTransition(order, target, notes, currentUserService.requireUserId(),
                order.getManufacturerOrganization().getId(), "/manufacturer/orders/" + orderId);
    }

    /** For other services (booking, shipments). No role check - the caller has already checked. */
    @Transactional
    public void systemTransition(ProductionOrder order, OrderStatus target, String notes, Long actorUserId) {
        applyTransition(order, target, notes, actorUserId, null, null);
    }

    /** Writes one timeline entry. Also used by OrderService when the order is created. */
    public void recordEvent(ProductionOrder order, OrderStatus from, OrderStatus to, Long actorUserId, String notes) {
        ProductionOrderEvent event = new ProductionOrderEvent();
        event.setProductionOrder(order);
        event.setPreviousStatus(from);
        event.setNewStatus(to);
        event.setUpdatedBy(userRepository.getReferenceById(actorUserId));
        event.setNotes(notes == null || notes.isBlank() ? null : notes.trim());
        eventRepository.save(event);
    }

    private void applyTransition(ProductionOrder order, OrderStatus target, String notes, Long actorUserId,
                                 Long notifyOrganizationId, String notifyLink) {
        OrderStatus from = order.getStatus();
        if (!from.canTransitionTo(target)) {
            throw new InvalidOrderTransitionException(from, target);
        }
        order.setStatus(target);
        recordEvent(order, from, target, actorUserId, notes);

        // Machine time is freed when an order is cancelled and closed when it is completed
        if (target == OrderStatus.CANCELLED || target == OrderStatus.COMPLETED) {
            ReservationStatus newReservationStatus = target == OrderStatus.CANCELLED
                    ? ReservationStatus.CANCELLED : ReservationStatus.COMPLETED;
            for (MachineReservation reservation : reservationRepository.findByProductionOrder_Id(order.getId())) {
                if (reservation.getStatus() == ReservationStatus.ACTIVE) {
                    reservation.setStatus(newReservationStatus);
                }
            }
        }

        if (notifyOrganizationId != null) {
            notificationService.notifyOrganization(notifyOrganizationId,
                    "Order " + order.getOrderNumber() + ": " + target.getLabel(),
                    "Status changed from '" + from.getLabel() + "' to '" + target.getLabel() + "'"
                            + (notes == null || notes.isBlank() ? "." : ": " + notes.trim()),
                    notifyLink);
        }
        auditService.record(actorUserId, "ORDER_STATUS_CHANGED", "ProductionOrder", order.getId(),
                from + " -> " + target);
    }

    private void checkPreconditions(ProductionOrder order, OrderStatus target) {
        if (target == OrderStatus.SCHEDULED) {
            boolean hasBooking = reservationRepository.findByProductionOrder_Id(order.getId()).stream()
                    .anyMatch(r -> r.getStatus() == ReservationStatus.ACTIVE);
            if (!hasBooking) {
                throw new BusinessRuleException("Book machine time before marking the order as scheduled.");
            }
        }
        if (target == OrderStatus.READY_TO_SHIP) {
            BigDecimal approved = batchRepository.findByProductionOrder_IdOrderByCreatedAtAsc(order.getId()).stream()
                    .filter(b -> b.getStatus() == BatchStatus.APPROVED)
                    .map(Batch::getQuantity)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            if (approved.compareTo(order.getQuantity()) < 0) {
                throw new BusinessRuleException("The full quantity must be in inspected and approved batches before shipping. "
                        + "Approved so far: " + approved.stripTrailingZeros().toPlainString()
                        + " of " + order.getQuantity().stripTrailingZeros().toPlainString() + ".");
            }
        }
    }

    // ================= Reading =================

    public List<OrderStatus> nextStatusesForManufacturer(OrderView order) {
        return order.status().allowedNext().stream()
                .filter(MANUFACTURER_STATUSES::contains)
                .sorted(Comparator.comparingInt(Enum::ordinal))
                .toList();
    }

    @Transactional(readOnly = true)
    public List<OrderTimelineItem> timeline(Long orderId) {
        ProductionOrder order = load(orderId);
        if (!accessGuard.isMemberOfAny(order.getBuyerOrganization().getId(), order.getManufacturerOrganization().getId())) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        return eventRepository.findByProductionOrder_IdOrderByCreatedAtAsc(orderId).stream()
                .map(mapper::toTimelineItem)
                .toList();
    }

    /** Production board: active orders grouped by status column. */
    @Transactional(readOnly = true)
    public Map<OrderStatus, List<OrderView>> board() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        Long orgId = currentUserService.requireOrganizationId();
        List<ProductionOrder> orders = orderRepository
                .findByManufacturerOrganization_IdAndStatusInOrderByExpectedCompletionAsc(orgId, BOARD_COLUMNS);

        Map<OrderStatus, List<OrderView>> columns = new LinkedHashMap<>();
        BOARD_COLUMNS.forEach(status -> columns.put(status, new java.util.ArrayList<>()));
        orders.forEach(order -> columns.get(order.getStatus()).add(mapper.toView(order)));
        return columns;
    }

    private ProductionOrder load(Long orderId) {
        return orderRepository.findWithDetailsById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
    }
}