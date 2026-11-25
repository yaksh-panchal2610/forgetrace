package com.forgetrace.dto.response;

import com.forgetrace.enums.InspectionStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record PassportView(
        UUID token,
        String batchNumber,
        BigDecimal quantity,
        String quantityUnit,
        LocalDate manufactureDate,
        String manufacturerName,
        String manufacturerLocation,
        String processName,
        String materialName,
        Instant inspectedAt,
        InspectionStatus inspectionResult,
        List<InspectionView.MeasurementRow> measurements,
        Instant publishedAt,
        boolean revoked,
        boolean recalled
) {
    public boolean isValid() {
        return !revoked && !recalled;
    }
}