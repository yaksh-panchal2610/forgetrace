package com.forgetrace.enums;

import java.util.EnumSet;
import java.util.Set;

public enum BatchStatus {
    CREATED("Created"),
    IN_PROGRESS("In progress"),
    AWAITING_INSPECTION("Awaiting inspection"),
    APPROVED("Approved"),
    REJECTED("Rejected"),
    ON_HOLD("On hold"),
    SHIPPED("Shipped"),
    RECALLED("Recalled");

    private final String label;

    BatchStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public Set<BatchStatus> allowedNext() {
        return switch (this) {
            case CREATED             -> EnumSet.of(IN_PROGRESS);
            case IN_PROGRESS         -> EnumSet.of(AWAITING_INSPECTION);
            case AWAITING_INSPECTION -> EnumSet.of(APPROVED, REJECTED, ON_HOLD);
            case ON_HOLD             -> EnumSet.of(AWAITING_INSPECTION, APPROVED, REJECTED);
            case REJECTED            -> EnumSet.of(IN_PROGRESS);
            case APPROVED            -> EnumSet.of(SHIPPED, RECALLED);
            case SHIPPED             -> EnumSet.of(RECALLED);
            case RECALLED            -> EnumSet.noneOf(BatchStatus.class);
        };
    }

    public boolean canTransitionTo(BatchStatus target) {
        return target != null && allowedNext().contains(target);
    }

    public boolean isFinal() {
        return this == RECALLED;
    }
}