package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.BatchStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "batches")
@Getter
@Setter
@NoArgsConstructor
public class Batch extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "production_order_id")
    private ProductionOrder productionOrder;

    @Column(nullable = false, unique = true, length = 40)
    private String batchNumber;

    @Column(nullable = false, precision = 14, scale = 3)
    private BigDecimal quantity;

    private LocalDate manufactureDate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 25)
    private BatchStatus status = BatchStatus.CREATED;
}