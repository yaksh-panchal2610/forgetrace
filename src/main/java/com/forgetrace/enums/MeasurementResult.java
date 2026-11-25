package com.forgetrace.enums;

import java.math.BigDecimal;

public enum MeasurementResult {
    PASS("Pass"),
    FAIL("Fail");

    private final String label;

    MeasurementResult(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static MeasurementResult evaluate(BigDecimal min, BigDecimal max, BigDecimal actual) {
        if (min == null || max == null || actual == null) {
            throw new IllegalArgumentException("min, max and actual are required");
        }
        boolean inRange = actual.compareTo(min) >= 0 && actual.compareTo(max) <= 0;
        return inRange ? PASS : FAIL;
    }
}