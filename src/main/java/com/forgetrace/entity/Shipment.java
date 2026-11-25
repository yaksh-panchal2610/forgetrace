package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.ShipmentStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "shipments")
@Getter
@Setter
@NoArgsConstructor
public class Shipment extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "production_order_id")
    private ProductionOrder productionOrder;

    @Column(nullable = false, length = 100)
    private String carrierName;

    @Column(length = 100)
    private String trackingNumber;

    private LocalDate dispatchDate;

    private LocalDate expectedDelivery;

    private Instant deliveredAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ShipmentStatus status = ShipmentStatus.PENDING;

    @OneToMany(mappedBy = "shipment", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ShipmentBatch> batches = new ArrayList<>();

    @OneToMany(mappedBy = "shipment", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("eventTime ASC")
    private List<ShipmentEvent> events = new ArrayList<>();
}