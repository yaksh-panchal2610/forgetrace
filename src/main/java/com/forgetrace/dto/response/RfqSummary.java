package com.forgetrace.dto.response;

import com.forgetrace.enums.RfqStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

/** One RFQ in a list (buyer's RFQ list or manufacturer's inbox). */
public record RfqSummary(
        Long id,
        String rfqNumber,
        String title,
        String buyerName,
        String processName,
        String materialName,
        BigDecimal quantity,
        String quantityUnit,
        LocalDate deliveryDate,
        Instant quoteDeadline,
        RfqStatus status,
        long quotationCount,
        boolean alreadyQuoted
) {
}