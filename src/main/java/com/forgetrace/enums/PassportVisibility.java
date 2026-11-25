package com.forgetrace.enums;

public enum PassportVisibility {
    PUBLIC("Public"),
    REVOKED("Revoked");

    private final String label;

    PassportVisibility(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}