package com.forgetrace.dto.response;

import java.util.List;

/** One manufacturer in the directory grid. */
public record ManufacturerCard(
        Long organizationId,
        String displayName,
        String location,
        Integer yearsInOperation,
        String shortDescription,
        List<String> processes,
        List<String> materials,
        Double averageRating
) {
}