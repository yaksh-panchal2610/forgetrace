package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public abstract class ForgeTraceException extends RuntimeException {

    private final HttpStatus status;

    protected ForgeTraceException(String message, HttpStatus status) {
        super(message);
        this.status = status;
    }

    protected ForgeTraceException(String message, HttpStatus status, Throwable cause) {
        super(message, cause);
        this.status = status;
    }

    public HttpStatus getStatus() {
        return status;
    }
}