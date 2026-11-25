package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class UnauthorizedOperationException extends ForgeTraceException {

    public UnauthorizedOperationException(String message) {
        super(message, HttpStatus.FORBIDDEN);
    }
}