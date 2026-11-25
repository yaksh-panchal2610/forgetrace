package com.forgetrace.service;

import com.forgetrace.dto.request.PaymentRequest;
import com.forgetrace.dto.response.PaymentResult;
import com.forgetrace.entity.Payment;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PaymentMethod;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.payment.GatewayRequest;
import com.forgetrace.payment.GatewayResult;
import com.forgetrace.payment.PaymentGateway;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.util.ReferenceNumberGenerator;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PaymentService {

    public static final Set<PaymentMethod> CUSTOMER_METHODS =
            EnumSet.of(PaymentMethod.CARD, PaymentMethod.UPI, PaymentMethod.NET_BANKING, PaymentMethod.WALLET);

    private final PaymentRepository paymentRepository;
    private final ProductionOrderRepository orderRepository;
    private final PaymentGateway gateway;
    private final NotificationService notificationService;
    private final ReferenceNumberGenerator referenceNumbers;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @PersistenceContext
    private EntityManager entityManager;

    public record CheckoutView(
            Long orderId,
            String orderNumber,
            String itemTitle,
            String manufacturerName,
            BigDecimal quantity,
            String quantityUnit,
            BigDecimal amount,
            String currency,
            OrderStatus orderStatus,
            boolean paid,
            boolean payable,
            String idempotencyKey,
            List<PaymentResult> payments
    ) {
    }

    @Transactional(readOnly = true)
    public CheckoutView checkout(Long orderId) {
        Long orgId = requireBuyer();
        ProductionOrder order = orderRepository.findWithDetailsById(orderId)
                .filter(o -> o.getBuyerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        boolean paid = paymentRepository.existsByProductionOrder_IdAndStatus(orderId, PaymentStatus.SUCCEEDED);
        return new CheckoutView(order.getId(), order.getOrderNumber(), order.getRfq().getTitle(),
                order.getManufacturerOrganization().getDisplayName(), order.getQuantity(), order.getRfq().getQuantityUnit(),
                order.getTotalAmount(), order.getCurrency(), order.getStatus(), paid,
                !paid && order.getStatus() != OrderStatus.CANCELLED,
                UUID.randomUUID().toString(), paymentsOf(orderId));
    }

    @Transactional
    public PaymentResult pay(Long orderId, PaymentRequest form) {
        Long orgId = requireBuyer();
        String key = form.getIdempotencyKey().trim();

        Optional<PaymentResult> replay = replay(key, orderId, orgId);
        if (replay.isPresent()) {
            return replay.get();
        }

        ProductionOrder order = entityManager.find(ProductionOrder.class, orderId, LockModeType.PESSIMISTIC_WRITE);
        if (order == null || !order.getBuyerOrganization().getId().equals(orgId)) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        replay = replay(key, orderId, orgId);
        if (replay.isPresent()) {
            return replay.get();
        }

        if (form.getMethod() == null || !CUSTOMER_METHODS.contains(form.getMethod())) {
            throw new BusinessRuleException("Choose a payment method.");
        }
        if (order.getStatus() == OrderStatus.CANCELLED) {
            throw new BusinessRuleException("This order was cancelled and cannot be paid.");
        }
        if (paymentRepository.existsByProductionOrder_IdAndStatus(orderId, PaymentStatus.SUCCEEDED)) {
            throw new BusinessRuleException("This order is already paid.");
        }

        Payment payment = new Payment();
        payment.setProductionOrder(order);
        payment.setPaymentReference(referenceNumbers.next("PAY"));
        payment.setProvider(gateway.name());
        payment.setIdempotencyKey(key);
        payment.setAmount(order.getTotalAmount());
        payment.setCurrency(order.getCurrency());
        payment.setPaymentMethod(form.getMethod());
        payment.setStatus(PaymentStatus.PENDING);
        paymentRepository.saveAndFlush(payment);

        GatewayResult result = gateway.charge(new GatewayRequest(payment.getPaymentReference(), payment.getAmount(),
                payment.getCurrency(), form.getMethod(), form.getCardNumber(), form.getUpiId()));

        Long userId = currentUserService.requireUserId();
        if (result.success()) {
            payment.setStatus(PaymentStatus.SUCCEEDED);
            payment.setProviderReference(result.providerReference());
            payment.setPaidAt(Instant.now());
            notificationService.notifyOrganization(order.getManufacturerOrganization().getId(),
                    "Payment received for " + order.getOrderNumber(),
                    order.getBuyerOrganization().getDisplayName() + " paid " + order.getCurrency() + " "
                            + order.getTotalAmount().toPlainString() + ". You can ship once the order is ready.",
                    "/manufacturer/payments");
            auditService.record(userId, "PAYMENT_SUCCEEDED", "Payment", payment.getId(), payment.getPaymentReference());
        } else {
            payment.setStatus(PaymentStatus.FAILED);
            payment.setFailureReason(result.failureReason());
            auditService.record(userId, "PAYMENT_FAILED", "Payment", payment.getId(), result.failureReason());
        }
        return toResult(payment, false);
    }

    @Transactional(readOnly = true)
    public List<PaymentResult> forOrder(Long orderId) {
        ProductionOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        boolean party = accessGuard.isAdmin() || accessGuard.isMemberOfAny(
                order.getBuyerOrganization().getId(), order.getManufacturerOrganization().getId());
        if (!party) {
            throw new ResourceNotFoundException("Order", orderId);
        }
        return paymentsOf(orderId);
    }

    @Transactional(readOnly = true)
    public boolean isPaid(Long orderId) {
        return paymentRepository.existsByProductionOrder_IdAndStatus(orderId, PaymentStatus.SUCCEEDED);
    }

    @Transactional(readOnly = true)
    public Page<PaymentResult> listForBuyer(int page) {
        Long orgId = requireBuyer();
        return paymentRepository.findByProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(orgId,
                PageRequest.of(Math.max(page, 0), 15)).map(p -> toResult(p, false));
    }

    @Transactional(readOnly = true)
    public Page<PaymentResult> listForManufacturer(int page) {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        Long orgId = currentUserService.requireOrganizationId();
        return paymentRepository.findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(orgId,
                PageRequest.of(Math.max(page, 0), 15)).map(p -> toResult(p, false));
    }

    private Optional<PaymentResult> replay(String key, Long orderId, Long orgId) {
        return paymentRepository.findByIdempotencyKey(key).map(p -> {
            ProductionOrder o = p.getProductionOrder();
            if (!o.getId().equals(orderId) || !o.getBuyerOrganization().getId().equals(orgId)) {
                throw new BusinessRuleException("Invalid payment request. Reload the page and try again.");
            }
            return toResult(p, true);
        });
    }

    private List<PaymentResult> paymentsOf(Long orderId) {
        return paymentRepository.findByProductionOrder_IdOrderByCreatedAtDesc(orderId).stream()
                .map(p -> toResult(p, false)).toList();
    }

    private PaymentResult toResult(Payment p, boolean replayed) {
        ProductionOrder o = p.getProductionOrder();
        return new PaymentResult(p.getId(), p.getPaymentReference(), o.getId(), o.getOrderNumber(),
                o.getBuyerOrganization().getDisplayName(), o.getManufacturerOrganization().getDisplayName(),
                p.getAmount(), p.getCurrency(), p.getPaymentMethod(), p.getStatus(), p.getFailureReason(),
                p.getProviderReference(), p.getPaidAt(), p.getCreatedAt(), replayed);
    }

    private Long requireBuyer() {
        accessGuard.requireRole(RoleName.BUYER);
        return currentUserService.requireOrganizationId();
    }
}