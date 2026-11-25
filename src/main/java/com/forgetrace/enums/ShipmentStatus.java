package com.forgetrace.enums;

public enum ShipmentStatus {
    PENDING("Pending"),
    DISPATCHED("Dispatched"),
    IN_TRANSIT("In transit"),
    DELIVERED("Delivered"),
    RETURNED("Returned"),
    CANCELLED("Cancelled");

    private final String label;

    ShipmentStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}