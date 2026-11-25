package com.forgetrace.enums;

import java.util.EnumSet;
import java.util.Set;

public enum OrderStatus {
    CONFIRMED("Confirmed"),
    SCHEDULED("Scheduled"),
    IN_PRODUCTION("In production"),
    QUALITY_CHECK("Quality check"),
    READY_TO_SHIP("Ready to ship"),
    SHIPPED("Shipped"),
    DELIVERED("Delivered"),
    COMPLETED("Completed"),
    ON_HOLD("On hold"),
    CANCELLED("Cancelled");

    private final String label;

    OrderStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public Set<OrderStatus> allowedNext() {
        return switch (this) {
            case CONFIRMED     -> EnumSet.of(SCHEDULED, ON_HOLD, CANCELLED);
            case SCHEDULED     -> EnumSet.of(IN_PRODUCTION, ON_HOLD, CANCELLED);
            case IN_PRODUCTION -> EnumSet.of(QUALITY_CHECK, ON_HOLD);
            case QUALITY_CHECK -> EnumSet.of(READY_TO_SHIP, IN_PRODUCTION, ON_HOLD);
            case READY_TO_SHIP -> EnumSet.of(SHIPPED, ON_HOLD);
            case SHIPPED       -> EnumSet.of(DELIVERED);
            case DELIVERED     -> EnumSet.of(COMPLETED);
            case ON_HOLD       -> EnumSet.of(SCHEDULED, IN_PRODUCTION, QUALITY_CHECK, READY_TO_SHIP, CANCELLED);
            case COMPLETED, CANCELLED -> EnumSet.noneOf(OrderStatus.class);
        };
    }

    public boolean canTransitionTo(OrderStatus target) {
        return target != null && allowedNext().contains(target);
    }

    public boolean isFinal() {
        return this == COMPLETED || this == CANCELLED;
    }
}