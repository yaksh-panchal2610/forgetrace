package com.forgetrace.mapper;

import com.forgetrace.dto.request.QuotationCreateRequest;
import com.forgetrace.dto.response.QuotationComparisonRow;
import com.forgetrace.entity.Quotation;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

@Component
public class QuotationMapper {

    public QuotationComparisonRow toRow(Quotation q, Instant now, boolean cheapest, boolean fastest, Double rating) {
        return new QuotationComparisonRow(
                q.getId(), q.getQuotationNumber(),
                q.getRfq().getId(), q.getRfq().getRfqNumber(), q.getRfq().getTitle(),
                q.getManufacturerOrganization().getId(), q.getManufacturerOrganization().getDisplayName(),
                q.getVersionNumber(),
                q.getUnitPrice(), q.getSetupFee(), q.getTaxAmount(), q.getTotalAmount(), q.getCurrency(),
                q.getLeadTimeDays(), q.getValidUntil(), q.getStatus(), q.getTerms(), q.getCreatedAt(),
                q.isExpired(now), cheapest, fastest, rating);
    }

    /** Pre-fills the "revise quotation" form from the previous version. */
    public QuotationCreateRequest toRevisionForm(Quotation previous, ZoneId zone) {
        QuotationCreateRequest form = new QuotationCreateRequest();
        form.setUnitPrice(previous.getUnitPrice());
        form.setSetupFee(previous.getSetupFee());
        form.setLeadTimeDays(previous.getLeadTimeDays());
        form.setTerms(previous.getTerms());

        BigDecimal subtotal = previous.getTotalAmount().subtract(previous.getTaxAmount());
        if (subtotal.signum() > 0) {
            form.setTaxRatePercent(previous.getTaxAmount()
                    .multiply(BigDecimal.valueOf(100))
                    .divide(subtotal, 2, RoundingMode.HALF_UP)
                    .stripTrailingZeros());
        }
        LocalDate previousValidUntil = previous.getValidUntil().atZone(zone).toLocalDate();
        LocalDate today = LocalDate.now(zone);
        form.setValidUntil(previousValidUntil.isBefore(today) ? today.plusDays(14) : previousValidUntil);
        return form;
    }
}