package com.forgetrace.enums;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.assertj.core.api.Assertions.assertThat;

class BatchStatusTest {

    @ParameterizedTest(name = "{0} -> {1} allowed = {2}")
    @CsvSource({
            "CREATED, IN_PROGRESS, true",
            "IN_PROGRESS, AWAITING_INSPECTION, true",
            "AWAITING_INSPECTION, APPROVED, true",
            "AWAITING_INSPECTION, REJECTED, true",
            "REJECTED, IN_PROGRESS, true",
            "APPROVED, SHIPPED, true",
            "APPROVED, RECALLED, true",
            "SHIPPED, RECALLED, true",
            "CREATED, APPROVED, false",
            "IN_PROGRESS, APPROVED, false",
            "REJECTED, APPROVED, false"
    })
    void transitions(BatchStatus from, BatchStatus to, boolean allowed) {
        assertThat(from.canTransitionTo(to)).isEqualTo(allowed);
    }
}