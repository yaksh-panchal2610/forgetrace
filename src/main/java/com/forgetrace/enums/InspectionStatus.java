package com.forgetrace.enums;

public enum InspectionStatus {
    PENDING("Pending"),
    PASSED("Passed"),
    FAILED("Failed"),
    ON_HOLD("On hold");

    private final String label;

    InspectionStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}