package com.forgetrace.payment;

import com.forgetrace.enums.PaymentMethod;

import java.math.BigDecimal;

public record GatewayRequest(
        String paymentReference,
        BigDecimal amount,
        String currency,
        PaymentMethod method,
        String cardNumber,
        String upiId
) {
}