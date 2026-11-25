package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class FileValidationException extends BusinessRuleException {

    public FileValidationException(String message) {
        super(message, HttpStatus.BAD_REQUEST);
    }
}