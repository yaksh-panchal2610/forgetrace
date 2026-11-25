package com.forgetrace.enums;

public enum PaymentStatus {
    CREATED("Created"),
    PENDING("Pending"),
    SUCCEEDED("Paid"),
    FAILED("Failed"),
    REFUNDED("Refunded");

    private final String label;

    PaymentStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public boolean isFinal() {
        return this == SUCCEEDED || this == FAILED || this == REFUNDED;
    }
}