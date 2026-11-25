package com.forgetrace.dto.response;

import com.forgetrace.enums.ShipmentStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record ShipmentView(
        Long id,
        Long orderId,
        String orderNumber,
        String itemTitle,
        String buyerName,
        String quantityUnit,
        String carrierName,
        String trackingNumber,
        LocalDate dispatchDate,
        LocalDate expectedDelivery,
        Instant deliveredAt,
        ShipmentStatus status,
        List<BatchRow> batches,
        List<EventRow> events
) {
    public record BatchRow(String batchNumber, BigDecimal quantity, UUID passportToken) {
        public boolean isHasPassport() {
            return passportToken != null;
        }
    }

    public record EventRow(ShipmentStatus status, Instant time, String location, String remarks) {
    }

    public boolean isOpen() {
        return status == ShipmentStatus.DISPATCHED || status == ShipmentStatus.IN_TRANSIT;
    }

    public BigDecimal getTotalQuantity() {
        return batches.stream().map(BatchRow::quantity).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}