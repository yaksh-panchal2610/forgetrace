package com.forgetrace.enums;

public enum OrganizationType {
    BUYER("Buyer"),
    MANUFACTURER("Manufacturer"),
    PLATFORM("Platform");

    private final String label;

    OrganizationType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}