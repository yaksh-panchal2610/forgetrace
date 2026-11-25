package com.forgetrace.service;

import com.forgetrace.dto.request.PaymentRequest;
import com.forgetrace.dto.response.PaymentResult;
import com.forgetrace.entity.Payment;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PaymentMethod;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.payment.GatewayRequest;
import com.forgetrace.payment.GatewayResult;
import com.forgetrace.payment.PaymentGateway;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.support.TestData;
import com.forgetrace.util.ReferenceNumberGenerator;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.util.ReflectionTestUtils;

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
class PaymentServiceTest {

    @Mock PaymentRepository paymentRepository;
    @Mock ProductionOrderRepository orderRepository;
    @Mock PaymentGateway gateway;
    @Mock NotificationService notificationService;
    @Mock ReferenceNumberGenerator referenceNumbers;
    @Mock CurrentUserService currentUserService;
    @Mock AccessGuard accessGuard;
    @Mock AuditService auditService;
    @Mock EntityManager entityManager;

    @InjectMocks PaymentService service;

    private ProductionOrder order;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(service, "entityManager", entityManager);
        order = TestData.order(1L, OrderStatus.CONFIRMED);
        when(currentUserService.requireOrganizationId()).thenReturn(TestData.BUYER_ORG);
        when(currentUserService.requireUserId()).thenReturn(5L);
        when(entityManager.find(ProductionOrder.class, 1L, LockModeType.PESSIMISTIC_WRITE)).thenReturn(order);
        when(paymentRepository.findByIdempotencyKey(anyString())).thenReturn(Optional.empty());
        when(referenceNumbers.next("PAY")).thenReturn("PAY-2026-TEST0001");
        when(gateway.name()).thenReturn("SANDBOX");
        when(paymentRepository.saveAndFlush(any(Payment.class))).thenAnswer(inv -> inv.getArgument(0));
    }

    private PaymentRequest card(String number, String key) {
        PaymentRequest r = new PaymentRequest();
        r.setMethod(PaymentMethod.CARD);
        r.setCardNumber(number);
        r.setIdempotencyKey(key);
        return r;
    }

    @Test
    @DisplayName("Successful card payment is SUCCEEDED and the manufacturer is notified")
    void successfulPayment() {
        when(gateway.charge(any(GatewayRequest.class))).thenReturn(GatewayResult.ok("sbx_OK"));

        PaymentResult result = service.pay(1L, card("4111111111111111", "key-1"));

        assertThat(result.status()).isEqualTo(PaymentStatus.SUCCEEDED);
        assertThat(result.amount()).isEqualByComparingTo("59000.00");
        assertThat(result.providerReference()).isEqualTo("sbx_OK");
        assertThat(result.replayed()).isFalse();
        verify(notificationService).notifyOrganization(eq(TestData.MANUFACTURER_ORG), anyString(), anyString(), anyString());
    }

    @Test
    @DisplayName("FT-024: declined card is recorded as FAILED and nobody is told it was paid")
    void declinedPayment() {
        when(gateway.charge(any(GatewayRequest.class))).thenReturn(GatewayResult.failed("Card declined"));

        PaymentResult result = service.pay(1L, card("4000000000000002", "key-2"));

        assertThat(result.status()).isEqualTo(PaymentStatus.FAILED);
        assertThat(result.failureReason()).isEqualTo("Card declined");
        verify(notificationService, never()).notifyOrganization(any(), anyString(), anyString(), anyString());
    }

    @Test
    @DisplayName("FT-023: same idempotency key returns the first payment and never charges again")
    void idempotentReplay() {
        Payment existing = new Payment();
        existing.setProductionOrder(order);
        existing.setPaymentReference("PAY-OLD");
        existing.setAmount(order.getTotalAmount());
        existing.setCurrency("INR");
        existing.setPaymentMethod(PaymentMethod.CARD);
        existing.setStatus(PaymentStatus.SUCCEEDED);
        when(paymentRepository.findByIdempotencyKey("key-1")).thenReturn(Optional.of(existing));

        PaymentResult result = service.pay(1L, card("4111111111111111", "key-1"));

        assertThat(result.replayed()).isTrue();
        assertThat(result.reference()).isEqualTo("PAY-OLD");
        verify(gateway, never()).charge(any());
        verify(paymentRepository, never()).saveAndFlush(any());
    }

    @Test
    void keyBelongingToAnotherOrderIsRejected() {
        Payment other = new Payment();
        other.setProductionOrder(TestData.order(2L, OrderStatus.CONFIRMED));
        when(paymentRepository.findByIdempotencyKey("stolen")).thenReturn(Optional.of(other));

        assertThatThrownBy(() -> service.pay(1L, card("4111111111111111", "stolen")))
                .isInstanceOf(BusinessRuleException.class);
    }

    @Test
    void alreadyPaidOrderCannotBePaidAgain() {
        when(paymentRepository.existsByProductionOrder_IdAndStatus(1L, PaymentStatus.SUCCEEDED)).thenReturn(true);

        assertThatThrownBy(() -> service.pay(1L, card("4111111111111111", "key-3")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("already paid");
        verify(gateway, never()).charge(any());
    }

    @Test
    void cancelledOrderCannotBePaid() {
        order.setStatus(OrderStatus.CANCELLED);

        assertThatThrownBy(() -> service.pay(1L, card("4111111111111111", "key-4")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("cancelled");
    }

    @Test
    void anotherBuyersOrderIsNotFound() {
        when(currentUserService.requireOrganizationId()).thenReturn(99L);

        assertThatThrownBy(() -> service.pay(1L, card("4111111111111111", "key-5")))
                .isInstanceOf(ResourceNotFoundException.class);
    }
}