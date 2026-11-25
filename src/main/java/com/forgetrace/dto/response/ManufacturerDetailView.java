package com.forgetrace.dto.response;

import java.time.Instant;
import java.util.List;

/** Public manufacturer profile page. Only approved public fields - no private contact data. */
public record ManufacturerDetailView(
        Long organizationId,
        String displayName,
        String location,
        Integer yearsInOperation,
        String description,
        String websiteUrl,
        List<String> processes,
        List<String> materials,
        long activeMachines,
        Double averageRating,
        int reviewCount,
        Instant memberSince
) {
}