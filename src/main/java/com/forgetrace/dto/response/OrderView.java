package com.forgetrace.dto.response;

import com.forgetrace.enums.OrderStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

/** A production order as shown in lists and on the detail page (for buyer and manufacturer). */
public record OrderView(
        Long id,
        String orderNumber,
        Long rfqId,
        String rfqNumber,
        String rfqTitle,
        Long processId,
        String processName,
        String materialName,
        Long buyerId,
        String buyerName,
        Long manufacturerId,
        String manufacturerName,
        String quotationNumber,
        int leadTimeDays,
        BigDecimal quantity,
        String quantityUnit,
        BigDecimal totalAmount,
        String currency,
        LocalDate expectedCompletion,
        String deliveryAddress,
        OrderStatus status,
        Instant createdAt
) {
    public boolean isFinished() {
        return status.isFinal();
    }
}