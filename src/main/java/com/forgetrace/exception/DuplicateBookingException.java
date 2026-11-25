package com.forgetrace.exception;

public class DuplicateBookingException extends BusinessRuleException {

    public DuplicateBookingException() {
        super("This machine is already reserved for part of the selected time.");
    }

    public DuplicateBookingException(String message) {
        super(message);
    }
}