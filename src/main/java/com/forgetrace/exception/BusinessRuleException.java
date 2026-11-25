package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class BusinessRuleException extends ForgeTraceException {

    public BusinessRuleException(String message) {
        super(message, HttpStatus.CONFLICT);
    }

    protected BusinessRuleException(String message, HttpStatus status) {
        super(message, status);
    }
}