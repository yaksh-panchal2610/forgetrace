package com.forgetrace.enums;

public enum RfqStatus {
    DRAFT("Draft"),
    OPEN("Open for quotes"),
    CLOSED("Closed"),
    AWARDED("Awarded"),
    CANCELLED("Cancelled"),
    EXPIRED("Expired");

    private final String label;

    RfqStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public boolean isAcceptingQuotes() {
        return this == OPEN;
    }
}