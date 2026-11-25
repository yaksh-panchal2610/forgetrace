package com.forgetrace.enums;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.assertj.core.api.Assertions.assertThat;

class OrderStatusTest {

    @ParameterizedTest(name = "{0} -> {1} allowed = {2}")
    @CsvSource({
            "CONFIRMED, SCHEDULED, true",
            "SCHEDULED, IN_PRODUCTION, true",
            "IN_PRODUCTION, QUALITY_CHECK, true",
            "QUALITY_CHECK, READY_TO_SHIP, true",
            "READY_TO_SHIP, SHIPPED, true",
            "SHIPPED, DELIVERED, true",
            "DELIVERED, COMPLETED, true",
            "CONFIRMED, SHIPPED, false",
            "IN_PRODUCTION, COMPLETED, false",
            "SHIPPED, CANCELLED, false",
            "COMPLETED, CANCELLED, false",
            "CANCELLED, SCHEDULED, false"
    })
    @DisplayName("Order lifecycle only allows the defined transitions")
    void transitions(OrderStatus from, OrderStatus to, boolean allowed) {
        assertThat(from.canTransitionTo(to)).isEqualTo(allowed);
    }

    @Test
    void nullTargetIsNeverAllowed() {
        assertThat(OrderStatus.CONFIRMED.canTransitionTo(null)).isFalse();
    }

    @Test
    void finalStatesHaveNoNextStep() {
        assertThat(OrderStatus.COMPLETED.isFinal()).isTrue();
        assertThat(OrderStatus.CANCELLED.allowedNext()).isEmpty();
        assertThat(OrderStatus.SHIPPED.isFinal()).isFalse();
    }
}