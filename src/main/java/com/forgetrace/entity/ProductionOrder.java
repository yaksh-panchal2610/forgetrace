package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.OrderStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "production_orders")
@Getter
@Setter
@NoArgsConstructor
public class ProductionOrder extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 30)
    private String orderNumber;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "accepted_quotation_id", unique = true)
    private Quotation acceptedQuotation;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "rfq_id", unique = true)
    private Rfq rfq;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "buyer_organization_id")
    private Organization buyerOrganization;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "manufacturer_organization_id")
    private Organization manufacturerOrganization;

    @Column(nullable = false, precision = 14, scale = 3)
    private BigDecimal quantity;

    @Column(nullable = false, precision = 14, scale = 2)
    private BigDecimal totalAmount;

    @Column(nullable = false, length = 3)
    private String currency = "INR";

    private LocalDate expectedCompletion;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private OrderStatus status = OrderStatus.CONFIRMED;
}