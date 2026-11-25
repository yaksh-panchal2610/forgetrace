package com.forgetrace.enums;

public enum ContactStatus {
    NEW("New"),
    IN_PROGRESS("In progress"),
    RESOLVED("Resolved");

    private final String label;

    ContactStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}