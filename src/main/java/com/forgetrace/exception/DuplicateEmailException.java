package com.forgetrace.exception;

public class DuplicateEmailException extends BusinessRuleException {

    public DuplicateEmailException() {
        super("An account with this email already exists");
    }
}