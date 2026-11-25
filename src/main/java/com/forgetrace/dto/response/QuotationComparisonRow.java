package com.forgetrace.dto.response;

import com.forgetrace.enums.QuotationStatus;

import java.math.BigDecimal;
import java.time.Instant;

/**
 * One quotation as shown in lists and the buyer's comparison table.
 * Full price breakdown is always shown - no hidden charges (dark-pattern checklist).
 */
public record QuotationComparisonRow(
        Long quotationId,
        String quotationNumber,
        Long rfqId,
        String rfqNumber,
        String rfqTitle,
        Long manufacturerId,
        String manufacturerName,
        int versionNumber,
        BigDecimal unitPrice,
        BigDecimal setupFee,
        BigDecimal taxAmount,
        BigDecimal totalAmount,
        String currency,
        int leadTimeDays,
        Instant validUntil,
        QuotationStatus status,
        String terms,
        Instant submittedAt,
        boolean expired,
        boolean cheapest,
        boolean fastest,
        Double manufacturerRating
) {
    /** Thymeleaf: ${row.acceptable} */
    public boolean isAcceptable() {
        return status == QuotationStatus.SUBMITTED && !expired;
    }
}