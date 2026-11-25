package com.forgetrace.dto.response;

import com.forgetrace.enums.BatchStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record BatchView(
        Long id,
        String batchNumber,
        Long orderId,
        String orderNumber,
        String itemTitle,
        String processName,
        String materialName,
        String manufacturerName,
        String buyerName,
        BigDecimal quantity,
        String quantityUnit,
        LocalDate manufactureDate,
        BatchStatus status,
        Instant updatedAt,
        UUID passportToken
) {
    public boolean isHasPassport() {
        return passportToken != null;
    }

    public boolean isInspectable() {
        return status == BatchStatus.AWAITING_INSPECTION || status == BatchStatus.ON_HOLD;
    }
}