package com.forgetrace.dto.response;

import com.forgetrace.enums.OrderStatus;

import java.time.Instant;

/** One status change in the order history. */
public record OrderTimelineItem(
        OrderStatus previousStatus,
        OrderStatus newStatus,
        String actorName,
        String notes,
        Instant at
) {
}