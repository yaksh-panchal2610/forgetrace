package com.forgetrace.enums;

public enum MachineStatus {
    ACTIVE("Active"),
    MAINTENANCE("Under maintenance"),
    INACTIVE("Inactive");

    private final String label;

    MachineStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public boolean isBookable() {
        return this == ACTIVE;
    }
}