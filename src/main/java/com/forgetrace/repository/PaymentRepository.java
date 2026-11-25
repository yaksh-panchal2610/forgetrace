package com.forgetrace.repository;

import com.forgetrace.entity.Payment;
import com.forgetrace.enums.PaymentStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    /** Same idempotency key = same payment (test FT-023: no duplicate charge). */
    Optional<Payment> findByIdempotencyKey(String idempotencyKey);

    Optional<Payment> findByPaymentReference(String paymentReference);

    List<Payment> findByProductionOrder_IdOrderByCreatedAtDesc(Long productionOrderId);

    boolean existsByProductionOrder_IdAndStatus(Long productionOrderId, PaymentStatus status);

    @EntityGraph(attributePaths = "productionOrder")
    Page<Payment> findByProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(Long buyerId, Pageable pageable);

    @EntityGraph(attributePaths = "productionOrder")
    Page<Payment> findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId, Pageable pageable);

    @EntityGraph(attributePaths = "productionOrder")
    Page<Payment> findAllByOrderByCreatedAtDesc(Pageable pageable);
}