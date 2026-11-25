package com.forgetrace.enums;

public enum DisputeStatus {
    OPEN("Open"),
    UNDER_REVIEW("Under review"),
    RESOLVED("Resolved"),
    REJECTED("Rejected");

    private final String label;

    DisputeStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}