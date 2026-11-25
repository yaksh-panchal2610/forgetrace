package com.forgetrace.service;

import com.forgetrace.dto.request.BatchCreateRequest;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.InvalidOrderTransitionException;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.support.TestData;
import com.forgetrace.util.ReferenceNumberGenerator;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.util.ReflectionTestUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class BatchServiceTest {

    @Mock BatchRepository batchRepository;
    @Mock ProductionOrderRepository orderRepository;
    @Mock ProductPassportRepository passportRepository;
    @Mock UserRepository userRepository;
    @Mock NotificationService notificationService;
    @Mock ReferenceNumberGenerator referenceNumbers;
    @Mock CurrentUserService currentUserService;
    @Mock AccessGuard accessGuard;
    @Mock AuditService auditService;

    @InjectMocks BatchService service;

    private ProductionOrder order;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(service, "displayZone", "Asia/Kolkata");
        order = TestData.order(1L, OrderStatus.IN_PRODUCTION);
        when(currentUserService.requireOrganizationId()).thenReturn(TestData.MANUFACTURER_ORG);
        when(currentUserService.requireUserId()).thenReturn(7L);
        when(orderRepository.findWithDetailsById(1L)).thenReturn(Optional.of(order));
        when(referenceNumbers.next("BAT")).thenReturn("BAT-2026-TEST0001");
    }

    private BatchCreateRequest form(String quantity) {
        BatchCreateRequest f = new BatchCreateRequest();
        f.setOrderId(1L);
        f.setQuantity(new BigDecimal(quantity));
        f.setManufactureDate(LocalDate.now().minusDays(1));
        return f;
    }

    @Test
    @DisplayName("FT-025: batch total cannot exceed the order quantity")
    void quantityAboveRemainingIsRejected() {
        when(batchRepository.sumQuantityForOrder(1L, BatchStatus.REJECTED)).thenReturn(new BigDecimal("80"));

        assertThatThrownBy(() -> service.create(form("30")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("exceeds")
                .hasMessageContaining("20");
        verify(batchRepository, never()).save(any());
    }

    @Test
    void exactRemainingQuantityIsAllowed() {
        when(batchRepository.sumQuantityForOrder(1L, BatchStatus.REJECTED)).thenReturn(new BigDecimal("80"));

        Batch batch = service.create(form("20"));

        assertThat(batch.getStatus()).isEqualTo(BatchStatus.CREATED);
        assertThat(batch.getBatchNumber()).isEqualTo("BAT-2026-TEST0001");
    }

    @Test
    @DisplayName("No earlier batches (sum = null) counts as zero")
    void firstBatchUsesZeroAsUsedQuantity() {
        when(batchRepository.sumQuantityForOrder(1L, BatchStatus.REJECTED)).thenReturn(null);
        ArgumentCaptor<Batch> saved = ArgumentCaptor.forClass(Batch.class);

        service.create(form("100"));

        verify(batchRepository).save(saved.capture());
        assertThat(saved.getValue().getQuantity()).isEqualByComparingTo("100");
        assertThat(saved.getValue().getProductionOrder()).isSameAs(order);
    }

    @Test
    void orderNotInProductionIsRejected() {
        order.setStatus(OrderStatus.CONFIRMED);

        assertThatThrownBy(() -> service.create(form("10")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("in production");
    }

    @Test
    void futureManufactureDateIsRejected() {
        BatchCreateRequest f = form("10");
        f.setManufactureDate(LocalDate.now().plusDays(5));

        assertThatThrownBy(() -> service.create(f))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("future");
    }

    @Test
    void manufacturerCannotApproveOwnBatch() {
        Batch batch = TestData.batch(3L, BatchStatus.IN_PROGRESS, order, "10");
        when(batchRepository.findById(3L)).thenReturn(Optional.of(batch));

        assertThatThrownBy(() -> service.advance(3L, BatchStatus.APPROVED))
                .isInstanceOf(InvalidOrderTransitionException.class);
        assertThat(batch.getStatus()).isEqualTo(BatchStatus.IN_PROGRESS);
    }

    @Test
    void sendingForInspectionNotifiesEveryInspector() {
        Batch batch = TestData.batch(3L, BatchStatus.IN_PROGRESS, order, "10");
        when(batchRepository.findById(3L)).thenReturn(Optional.of(batch));
        when(userRepository.findByRoles_RoleName(RoleName.QUALITY_INSPECTOR))
                .thenReturn(List.of(TestData.user(1L, "Insp One"), TestData.user(2L, "Insp Two")));

        service.advance(3L, BatchStatus.AWAITING_INSPECTION);

        assertThat(batch.getStatus()).isEqualTo(BatchStatus.AWAITING_INSPECTION);
        verify(notificationService, org.mockito.Mockito.times(2)).send(any());
    }
}