package com.forgetrace.enums;

public enum QuotationStatus {
    SUBMITTED("Submitted"),
    SUPERSEDED("Replaced by newer version"),
    ACCEPTED("Accepted"),
    REJECTED("Rejected"),
    EXPIRED("Expired"),
    WITHDRAWN("Withdrawn");

    private final String label;

    QuotationStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public boolean isAcceptable() {
        return this == SUBMITTED;
    }
}