package com.forgetrace.entity;

import com.forgetrace.entity.base.CreatedEntity;
import com.forgetrace.enums.ShipmentStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Entity
@Table(name = "shipment_events")
@Getter
@Setter
@NoArgsConstructor
public class ShipmentEvent extends CreatedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shipment_id")
    private Shipment shipment;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ShipmentStatus eventStatus;

    @Column(nullable = false)
    private Instant eventTime = Instant.now();

    @Column(length = 160)
    private String location;

    @Column(length = 255)
    private String remarks;
}