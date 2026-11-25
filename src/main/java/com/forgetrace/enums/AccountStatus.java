package com.forgetrace.enums;

public enum AccountStatus {
    PENDING("Pending"),
    ACTIVE("Active"),
    SUSPENDED("Suspended");

    private final String label;

    AccountStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public boolean canLogin() {
        return this == ACTIVE;
    }
}