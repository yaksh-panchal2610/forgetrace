package com.forgetrace.enums;

public enum AcknowledgementStatus {
    PENDING("Pending"),
    ACKNOWLEDGED("Acknowledged");

    private final String label;

    AcknowledgementStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}