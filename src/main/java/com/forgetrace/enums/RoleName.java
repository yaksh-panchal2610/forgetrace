package com.forgetrace.enums;

public enum RoleName {
    BUYER("Buyer"),
    MANUFACTURER("Manufacturer"),
    QUALITY_INSPECTOR("Quality Inspector"),
    ADMIN("Administrator");

    private final String label;

    RoleName(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public String authority() {
        return "ROLE_" + name();
    }
}