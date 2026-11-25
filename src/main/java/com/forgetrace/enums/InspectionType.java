package com.forgetrace.enums;

public enum InspectionType {
    INCOMING("Incoming material"),
    IN_PROCESS("In-process"),
    FINAL("Final inspection");

    private final String label;

    InspectionType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}