package com.forgetrace.dto.response;

import com.forgetrace.enums.PaymentMethod;
import com.forgetrace.enums.PaymentStatus;

import java.math.BigDecimal;
import java.time.Instant;

public record PaymentResult(
        Long id,
        String reference,
        Long orderId,
        String orderNumber,
        String buyerName,
        String manufacturerName,
        BigDecimal amount,
        String currency,
        PaymentMethod method,
        PaymentStatus status,
        String failureReason,
        String providerReference,
        Instant paidAt,
        Instant createdAt,
        boolean replayed
) {
    public boolean isSucceeded() {
        return status == PaymentStatus.SUCCEEDED;
    }
}