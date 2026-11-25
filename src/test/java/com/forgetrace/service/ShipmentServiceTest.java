package com.forgetrace.service;

import com.forgetrace.dto.request.ShipmentRequest;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Shipment;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.enums.ShipmentStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.ShipmentRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.support.TestData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class ShipmentServiceTest {

    @Mock ShipmentRepository shipmentRepository;
    @Mock ProductionOrderRepository orderRepository;
    @Mock BatchRepository batchRepository;
    @Mock PaymentRepository paymentRepository;
    @Mock ProductPassportRepository passportRepository;
    @Mock ProductionService productionService;
    @Mock NotificationService notificationService;
    @Mock CurrentUserService currentUserService;
    @Mock AccessGuard accessGuard;
    @Mock AuditService auditService;

    @InjectMocks ShipmentService service;

    private ProductionOrder order;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(service, "displayZone", "Asia/Kolkata");
        order = TestData.order(1L, OrderStatus.READY_TO_SHIP);
        when(currentUserService.requireOrganizationId()).thenReturn(TestData.MANUFACTURER_ORG);
        when(currentUserService.requireUserId()).thenReturn(7L);
        when(orderRepository.findWithDetailsById(1L)).thenReturn(Optional.of(order));
        when(paymentRepository.existsByProductionOrder_IdAndStatus(1L, PaymentStatus.SUCCEEDED)).thenReturn(true);
        when(shipmentRepository.save(any(Shipment.class))).thenAnswer(inv -> {
            Shipment s = inv.getArgument(0);
            s.setId(50L);
            return s;
        });
    }

    private ShipmentRequest form() {
        ShipmentRequest f = new ShipmentRequest();
        f.setOrderId(1L);
        f.setCarrierName("Blue Dart");
        f.setTrackingNumber("AWB123");
        f.setDispatchDate(LocalDate.now().minusDays(1));
        return f;
    }

    @Test
    void unpaidOrderCannotBeShipped() {
        when(paymentRepository.existsByProductionOrder_IdAndStatus(1L, PaymentStatus.SUCCEEDED)).thenReturn(false);

        assertThatThrownBy(() -> service.create(form()))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("not paid");
        verify(shipmentRepository, never()).save(any());
    }

    @Test
    void orderMustBeReadyToShip() {
        order.setStatus(OrderStatus.QUALITY_CHECK);

        assertThatThrownBy(() -> service.create(form()))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("Ready to ship");
    }

    @Test
    void expectedDeliveryBeforeDispatchIsRejected() {
        ShipmentRequest f = form();
        f.setExpectedDelivery(f.getDispatchDate().minusDays(2));

        assertThatThrownBy(() -> service.create(f))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("Expected delivery");
    }

    @Test
    void shipsOnlyApprovedBatchesAndMovesOrderToShipped() {
        Batch approved = TestData.batch(3L, BatchStatus.APPROVED, order, "100");
        Batch rejected = TestData.batch(4L, BatchStatus.REJECTED, order, "20");
        when(batchRepository.findByProductionOrder_IdOrderByCreatedAtAsc(1L)).thenReturn(List.of(approved, rejected));

        Shipment shipment = service.create(form());

        assertThat(shipment.getStatus()).isEqualTo(ShipmentStatus.DISPATCHED);
        assertThat(shipment.getBatches()).hasSize(1);
        assertThat(shipment.getEvents()).hasSize(1);
        assertThat(approved.getStatus()).isEqualTo(BatchStatus.SHIPPED);
        assertThat(rejected.getStatus()).isEqualTo(BatchStatus.REJECTED);
        verify(productionService).systemTransition(eq(order), eq(OrderStatus.SHIPPED), anyString(), eq(7L));
        verify(notificationService).notifyOrganization(eq(TestData.BUYER_ORG), anyString(), anyString(), anyString());
    }
}