package com.forgetrace.service;

import com.forgetrace.dto.request.ShipmentEventRequest;
import com.forgetrace.dto.request.ShipmentRequest;
import com.forgetrace.dto.response.ShipmentView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductPassport;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Shipment;
import com.forgetrace.entity.ShipmentBatch;
import com.forgetrace.entity.ShipmentEvent;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.enums.ShipmentStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.ShipmentRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.EnumSet;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShipmentService {

    private final ShipmentRepository shipmentRepository;
    private final ProductionOrderRepository orderRepository;
    private final BatchRepository batchRepository;
    private final PaymentRepository paymentRepository;
    private final ProductPassportRepository passportRepository;
    private final ProductionService productionService;
    private final NotificationService notificationService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    public record ReadyOrder(Long id, String orderNumber, String title, String buyerName, boolean paid) {
    }

    public record TrackingView(Long orderId, String orderNumber, String itemTitle, String manufacturerName,
                               OrderStatus status, boolean paid, List<ShipmentView> shipments) {
    }

    @Transactional(readOnly = true)
    public List<ReadyOrder> readyOrders() {
        Long orgId = requireManufacturer();
        return orderRepository.findByManufacturerOrganization_IdAndStatusInOrderByExpectedCompletionAsc(orgId,
                        EnumSet.of(OrderStatus.READY_TO_SHIP))
                .stream()
                .map(o -> new ReadyOrder(o.getId(), o.getOrderNumber(), o.getRfq().getTitle(),
                        o.getBuyerOrganization().getDisplayName(),
                        paymentRepository.existsByProductionOrder_IdAndStatus(o.getId(), PaymentStatus.SUCCEEDED)))
                .toList();
    }

    @Transactional
    public Shipment create(ShipmentRequest form) {
        Long orgId = requireManufacturer();
        Long userId = currentUserService.requireUserId();
        ProductionOrder order = orderRepository.findWithDetailsById(form.getOrderId())
                .filter(o -> o.getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", form.getOrderId()));

        if (order.getStatus() != OrderStatus.READY_TO_SHIP) {
            throw new BusinessRuleException("Only orders that are 'Ready to ship' can be shipped.");
        }
        if (!paymentRepository.existsByProductionOrder_IdAndStatus(order.getId(), PaymentStatus.SUCCEEDED)) {
            throw new BusinessRuleException("The buyer has not paid for this order yet.");
        }
        LocalDate today = LocalDate.now(ZoneId.of(displayZone));
        if (form.getDispatchDate().isAfter(today)) {
            throw new BusinessRuleException("Dispatch date cannot be in the future.");
        }
        if (form.getExpectedDelivery() != null && form.getExpectedDelivery().isBefore(form.getDispatchDate())) {
            throw new BusinessRuleException("Expected delivery cannot be before the dispatch date.");
        }
        List<Batch> approved = batchRepository.findByProductionOrder_IdOrderByCreatedAtAsc(order.getId()).stream()
                .filter(b -> b.getStatus() == BatchStatus.APPROVED)
                .toList();
        if (approved.isEmpty()) {
            throw new BusinessRuleException("This order has no approved batches to ship.");
        }

        Shipment shipment = new Shipment();
        shipment.setProductionOrder(order);
        shipment.setCarrierName(form.getCarrierName().trim());
        shipment.setTrackingNumber(blankToNull(form.getTrackingNumber()));
        shipment.setDispatchDate(form.getDispatchDate());
        shipment.setExpectedDelivery(form.getExpectedDelivery());
        shipment.setStatus(ShipmentStatus.DISPATCHED);
        shipmentRepository.save(shipment);

        for (Batch batch : approved) {
            batch.setStatus(BatchStatus.SHIPPED);
            shipment.getBatches().add(new ShipmentBatch(shipment, batch, batch.getQuantity()));
        }
        addEvent(shipment, ShipmentStatus.DISPATCHED, form.getLocation(),
                form.getRemarks() == null || form.getRemarks().isBlank() ? "Dispatched via " + shipment.getCarrierName() : form.getRemarks());

        String tracking = shipment.getTrackingNumber() == null ? "" : " (tracking " + shipment.getTrackingNumber() + ")";
        productionService.systemTransition(order, OrderStatus.SHIPPED, "Shipped via " + shipment.getCarrierName() + tracking, userId);
        notificationService.notifyOrganization(order.getBuyerOrganization().getId(),
                "Order " + order.getOrderNumber() + " shipped",
                "Carrier: " + shipment.getCarrierName() + tracking + ". " + approved.size() + " batch(es) on the way.",
                "/buyer/orders/" + order.getId() + "/tracking");
        auditService.record(userId, "SHIPMENT_CREATED", "Shipment", shipment.getId(), order.getOrderNumber());
        return shipment;
    }

    @Transactional
    public void addEvent(Long shipmentId, ShipmentEventRequest form) {
        Long orgId = requireManufacturer();
        Long userId = currentUserService.requireUserId();
        Shipment shipment = shipmentRepository.findById(shipmentId)
                .filter(s -> s.getProductionOrder().getManufacturerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Shipment", shipmentId));
        ShipmentStatus target = form.getStatus();
        if (target != ShipmentStatus.IN_TRANSIT && target != ShipmentStatus.DELIVERED) {
            throw new BusinessRuleException("Choose 'In transit' or 'Delivered'.");
        }
        if (shipment.getStatus() != ShipmentStatus.DISPATCHED && shipment.getStatus() != ShipmentStatus.IN_TRANSIT) {
            throw new BusinessRuleException("This shipment is already closed.");
        }

        addEvent(shipment, target, form.getLocation(), form.getRemarks());
        shipment.setStatus(target);
        ProductionOrder order = shipment.getProductionOrder();

        if (target == ShipmentStatus.DELIVERED) {
            shipment.setDeliveredAt(Instant.now());
            productionService.systemTransition(order, OrderStatus.DELIVERED, "Delivered by " + shipment.getCarrierName(), userId);
            notificationService.notifyOrganization(order.getBuyerOrganization().getId(),
                    "Order " + order.getOrderNumber() + " delivered",
                    "Please check the goods and mark the order as completed.",
                    "/buyer/orders/" + order.getId());
        } else {
            notificationService.notifyOrganization(order.getBuyerOrganization().getId(),
                    "Shipment update for " + order.getOrderNumber(),
                    "In transit" + (form.getLocation() == null || form.getLocation().isBlank() ? "" : " at " + form.getLocation().trim()),
                    "/buyer/orders/" + order.getId() + "/tracking");
        }
        auditService.record(userId, "SHIPMENT_EVENT", "Shipment", shipmentId, target.name());
    }

    @Transactional(readOnly = true)
    public Page<ShipmentView> listMine(int page) {
        Long orgId = requireManufacturer();
        return shipmentRepository.findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(orgId,
                PageRequest.of(Math.max(page, 0), 15)).map(this::toView);
    }

    @Transactional(readOnly = true)
    public ShipmentView detail(Long shipmentId) {
        Long orgId = requireManufacturer();
        return shipmentRepository.findById(shipmentId)
                .filter(s -> s.getProductionOrder().getManufacturerOrganization().getId().equals(orgId))
                .map(this::toView)
                .orElseThrow(() -> new ResourceNotFoundException("Shipment", shipmentId));
    }

    @Transactional(readOnly = true)
    public TrackingView tracking(Long orderId) {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        ProductionOrder order = orderRepository.findWithDetailsById(orderId)
                .filter(o -> o.getBuyerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        List<ShipmentView> shipments = shipmentRepository.findByProductionOrder_IdOrderByCreatedAtDesc(orderId)
                .stream().map(this::toView).toList();
        return new TrackingView(order.getId(), order.getOrderNumber(), order.getRfq().getTitle(),
                order.getManufacturerOrganization().getDisplayName(), order.getStatus(),
                paymentRepository.existsByProductionOrder_IdAndStatus(orderId, PaymentStatus.SUCCEEDED), shipments);
    }

    private void addEvent(Shipment shipment, ShipmentStatus status, String location, String remarks) {
        ShipmentEvent event = new ShipmentEvent();
        event.setShipment(shipment);
        event.setEventStatus(status);
        event.setEventTime(Instant.now());
        event.setLocation(blankToNull(location));
        event.setRemarks(blankToNull(remarks));
        shipment.getEvents().add(event);
    }

    private ShipmentView toView(Shipment s) {
        ProductionOrder o = s.getProductionOrder();
        List<ShipmentView.BatchRow> batches = s.getBatches().stream()
                .map(sb -> new ShipmentView.BatchRow(sb.getBatch().getBatchNumber(), sb.getQuantity(),
                        passportRepository.findByBatch_Id(sb.getBatch().getId()).map(ProductPassport::getPublicToken).orElse(null)))
                .toList();
        List<ShipmentView.EventRow> events = new ArrayList<>(s.getEvents().stream()
                .map(e -> new ShipmentView.EventRow(e.getEventStatus(), e.getEventTime(), e.getLocation(), e.getRemarks()))
                .toList());
        Collections.reverse(events);
        return new ShipmentView(s.getId(), o.getId(), o.getOrderNumber(), o.getRfq().getTitle(),
                o.getBuyerOrganization().getDisplayName(), o.getRfq().getQuantityUnit(), s.getCarrierName(),
                s.getTrackingNumber(), s.getDispatchDate(), s.getExpectedDelivery(), s.getDeliveredAt(), s.getStatus(),
                batches, events);
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private Long requireManufacturer() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }
}