package com.forgetrace.exception;

import org.springframework.http.HttpStatus;

public class InvalidTokenException extends BusinessRuleException {

    public InvalidTokenException() {
        super("This link is invalid or has expired. Please request a new one.", HttpStatus.BAD_REQUEST);
    }
}