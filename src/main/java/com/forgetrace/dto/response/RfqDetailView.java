package com.forgetrace.dto.response;

import com.forgetrace.enums.RfqStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

/** Everything shown on an RFQ detail page. */
public record RfqDetailView(
        Long id,
        String rfqNumber,
        String title,
        String description,
        Long buyerOrganizationId,
        String buyerName,
        String processName,
        String materialName,
        BigDecimal quantity,
        String quantityUnit,
        List<SpecItem> specifications,
        String toleranceNotes,
        LocalDate deliveryDate,
        String deliveryAddress,
        Instant quoteDeadline,
        RfqStatus status,
        Instant createdAt,
        List<AttachmentItem> attachments,
        boolean openForQuotes
) {
    public record SpecItem(String name, String value) {
    }

    public record AttachmentItem(Long fileId, String filename, long sizeBytes) {
    }

    public boolean isCancellable() {
        return status == RfqStatus.OPEN || status == RfqStatus.CLOSED;
    }
}