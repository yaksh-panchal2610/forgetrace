package com.forgetrace.enums;

public enum RecallStatus {
    INITIATED("Initiated"),
    NOTIFIED("Recipients notified"),
    CLOSED("Closed");

    private final String label;

    RecallStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}