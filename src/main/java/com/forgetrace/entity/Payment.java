package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.PaymentMethod;
import com.forgetrace.enums.PaymentStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "payments")
@Getter
@Setter
@NoArgsConstructor
public class Payment extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "production_order_id")
    private ProductionOrder productionOrder;

    @Column(nullable = false, unique = true, length = 40)
    private String paymentReference;

    @Column(nullable = false, length = 30)
    private String provider = "SANDBOX";

    @Column(length = 100)
    private String providerReference;

    /** Same key sent twice = same payment. Prevents double charging. */
    @Column(nullable = false, unique = true, length = 80)
    private String idempotencyKey;

    @Column(nullable = false, precision = 14, scale = 2)
    private BigDecimal amount;

    @Column(nullable = false, length = 3)
    private String currency = "INR";

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private PaymentMethod paymentMethod;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private PaymentStatus status = PaymentStatus.CREATED;

    @Column(length = 255)
    private String failureReason;

    private Instant paidAt;
}