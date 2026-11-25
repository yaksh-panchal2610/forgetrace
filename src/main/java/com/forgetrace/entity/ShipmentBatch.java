package com.forgetrace.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

/** Which batches (and how much of each) are inside a shipment. */
@Entity
@Table(name = "shipment_batches")
@Getter
@Setter
@NoArgsConstructor
public class ShipmentBatch {

    @EmbeddedId
    private ShipmentBatchId id = new ShipmentBatchId();

    @MapsId("shipmentId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shipment_id")
    private Shipment shipment;

    @MapsId("batchId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "batch_id")
    private Batch batch;

    @Column(nullable = false, precision = 14, scale = 3)
    private BigDecimal quantity;

    public ShipmentBatch(Shipment shipment, Batch batch, BigDecimal quantity) {
        this.shipment = shipment;
        this.batch = batch;
        this.quantity = quantity;
        this.id = new ShipmentBatchId(shipment.getId(), batch.getId());
    }
}