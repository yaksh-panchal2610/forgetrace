package com.forgetrace.dto.response;

import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.InspectionType;
import com.forgetrace.enums.MeasurementResult;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

public record InspectionView(
        Long id,
        Long batchId,
        String batchNumber,
        String inspectorName,
        InspectionType type,
        InspectionStatus status,
        String findings,
        Instant inspectedAt,
        List<MeasurementRow> measurements
) {
    public record MeasurementRow(String parameterName, BigDecimal expectedMin, BigDecimal expectedMax,
                                 BigDecimal actualValue, String unit, MeasurementResult result, String remarks) {
        public boolean isPass() {
            return result == MeasurementResult.PASS;
        }
    }

    public long getFailedCount() {
        return measurements.stream().filter(m -> !m.isPass()).count();
    }
}