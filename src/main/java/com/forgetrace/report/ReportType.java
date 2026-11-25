package com.forgetrace.report;

public enum ReportType {
    ORDERS("Orders summary"),
    PAYMENTS("Payments"),
    QUALITY("Quality inspections");

    private final String label;

    ReportType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}