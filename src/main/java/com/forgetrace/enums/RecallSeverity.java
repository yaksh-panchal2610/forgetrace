package com.forgetrace.enums;

public enum RecallSeverity {
    LOW("Low"),
    MEDIUM("Medium"),
    HIGH("High"),
    CRITICAL("Critical");

    private final String label;

    RecallSeverity(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}