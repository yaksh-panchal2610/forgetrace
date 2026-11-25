package com.forgetrace.enums;

public enum VerificationStatus {
    PENDING("Pending review"),
    VERIFIED("Verified"),
    REJECTED("Rejected");

    private final String label;

    VerificationStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}