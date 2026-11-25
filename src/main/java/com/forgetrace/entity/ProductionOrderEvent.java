package com.forgetrace.entity;

import com.forgetrace.entity.base.CreatedEntity;
import com.forgetrace.enums.OrderStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** One row per status change - builds the order timeline. */
@Entity
@Table(name = "production_order_events")
@Getter
@Setter
@NoArgsConstructor
public class ProductionOrderEvent extends CreatedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "production_order_id")
    private ProductionOrder productionOrder;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private OrderStatus previousStatus;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private OrderStatus newStatus;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "updated_by")
    private User updatedBy;

    @Column(columnDefinition = "text")
    private String notes;
}