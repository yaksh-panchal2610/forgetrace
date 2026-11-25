package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class PaymentFailedException extends BusinessRuleException {

    public PaymentFailedException(String message) {
        super(message, HttpStatus.PAYMENT_REQUIRED);
    }
}