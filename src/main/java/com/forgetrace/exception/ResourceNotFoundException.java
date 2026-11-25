package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class ResourceNotFoundException extends ForgeTraceException {

    public ResourceNotFoundException(String message) {
        super(message, HttpStatus.NOT_FOUND);
    }

    public ResourceNotFoundException(String resourceName, Object id) {
        super(resourceName + " not found: " + id, HttpStatus.NOT_FOUND);
    }
}