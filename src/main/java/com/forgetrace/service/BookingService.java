package com.forgetrace.service;

import com.forgetrace.dto.request.BookingRequest;
import com.forgetrace.entity.Machine;
import com.forgetrace.entity.MachineReservation;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.ReservationStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.DuplicateBookingException;
import com.forgetrace.exception.MachineUnavailableException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.MachineReservationRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

/**
 * Machine booking for an order (tests FT-021 overlap, FT-022 inactive machine).
 * Checks: ownership -> order state -> machine supports the process -> AvailabilityService
 * (status, working hours, maintenance, existing reservations).
 * The PostgreSQL exclusion constraint is the final guard if two bookings race each other.
 */
@Service
@RequiredArgsConstructor
public class BookingService {

    private static final Set<OrderStatus> BOOKABLE_ORDER_STATUSES = EnumSet.of(
            OrderStatus.CONFIRMED, OrderStatus.SCHEDULED, OrderStatus.IN_PRODUCTION, OrderStatus.ON_HOLD);

    private final MachineReservationRepository reservationRepository;
    private final MachineRepository machineRepository;
    private final ProductionOrderRepository orderRepository;
    private final UserRepository userRepository;
    private final AvailabilityService availabilityService;
    private final ProductionService productionService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    /** One reservation as shown on the order page. */
    public record ReservationView(Long id, Long machineId, String machineName, Instant startAt, Instant endAt,
                                  ReservationStatus status) {
        public boolean isActive() {
            return status == ReservationStatus.ACTIVE;
        }
    }

    @Transactional
    public ReservationView book(BookingRequest request) {
        Long orgId = requireManufacturerOrganization();
        Long userId = currentUserService.requireUserId();

        ProductionOrder order = orderRepository.findWithDetailsById(request.getOrderId())
                .filter(o -> o.getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", request.getOrderId()));
        if (!BOOKABLE_ORDER_STATUSES.contains(order.getStatus())) {
            throw new BusinessRuleException("Machine time cannot be booked for an order that is "
                    + order.getStatus().getLabel().toLowerCase() + ".");
        }

        Machine machine = machineRepository.findByIdAndOrganization_Id(request.getMachineId(), orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Machine", request.getMachineId()));
        Long processId = order.getRfq().getProcess().getId();
        if (machine.getProcesses().stream().noneMatch(p -> p.getId().equals(processId))) {
            throw new MachineUnavailableException("Machine '" + machine.getMachineName()
                    + "' does not support " + order.getRfq().getProcess().getProcessName() + ".");
        }

        ZoneId zone = ZoneId.of(displayZone);
        Instant start = request.getStartAt().atZone(zone).toInstant();
        Instant end = request.getEndAt().atZone(zone).toInstant();
        if (start.isBefore(Instant.now())) {
            throw new BusinessRuleException("A booking cannot start in the past.");
        }

        // Status, working hours, maintenance and overlapping reservations
        availabilityService.checkAvailability(machine, start, end);

        MachineReservation reservation = new MachineReservation();
        reservation.setMachine(machine);
        reservation.setProductionOrder(order);
        reservation.setStartAt(start);
        reservation.setEndAt(end);
        reservation.setStatus(ReservationStatus.ACTIVE);
        reservation.setReservedBy(userRepository.getReferenceById(userId));
        try {
            reservationRepository.saveAndFlush(reservation);
        } catch (DataIntegrityViolationException ex) {
            // The database exclusion constraint caught an overlap created by a parallel request
            throw new DuplicateBookingException();
        }

        // The first booking moves a confirmed order to "Scheduled" automatically
        if (order.getStatus() == OrderStatus.CONFIRMED) {
            productionService.systemTransition(order, OrderStatus.SCHEDULED, "Machine time booked on " + machine.getMachineName(), userId);
        }

        auditService.record(userId, "MACHINE_BOOKED", "MachineReservation", reservation.getId(),
                machine.getMachineName() + " for " + order.getOrderNumber());
        return toView(reservation);
    }

    @Transactional
    public void cancel(Long reservationId) {
        Long orgId = requireManufacturerOrganization();
        MachineReservation reservation = reservationRepository.findById(reservationId)
                .filter(r -> r.getMachine().getOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Booking", reservationId));
        if (reservation.getStatus() != ReservationStatus.ACTIVE) {
            throw new BusinessRuleException("Only active bookings can be cancelled.");
        }
        reservation.setStatus(ReservationStatus.CANCELLED);
        auditService.record(currentUserService.requireUserId(), "BOOKING_CANCELLED", "MachineReservation", reservationId, null);
    }

    /** Bookings for an order - visible to its buyer and its manufacturer. */
    @Transactional(readOnly = true)
    public List<ReservationView> reservationsForOrder(Long orderId) {
        ProductionOrder order = orderRepository.findWithDetailsById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        if (!accessGuard.isMemberOfAny(order.getBuyerOrganization().getId(), order.getManufacturerOrganization().getId())) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        return reservationRepository.findByProductionOrder_Id(orderId).stream()
                .sorted(Comparator.comparing(MachineReservation::getStartAt))
                .map(this::toView)
                .toList();
    }

    /** This manufacturer's active machines that can do the order's process. */
    @Transactional(readOnly = true)
    public List<Machine> machinesForOrder(Long orderId) {
        Long orgId = requireManufacturerOrganization();
        ProductionOrder order = orderRepository.findWithDetailsById(orderId)
                .filter(o -> o.getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        Long processId = order.getRfq().getProcess().getId();
        return machineRepository.findByOrganization_IdOrderByMachineNameAsc(orgId).stream()
                .filter(Machine::isBookable)
                .filter(m -> m.getProcesses().stream().anyMatch(p -> p.getId().equals(processId)))
                .toList();
    }

    private ReservationView toView(MachineReservation r) {
        return new ReservationView(r.getId(), r.getMachine().getId(), r.getMachine().getMachineName(),
                r.getStartAt(), r.getEndAt(), r.getStatus());
    }

    private Long requireManufacturerOrganization() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }
}