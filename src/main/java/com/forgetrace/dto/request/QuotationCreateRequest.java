package com.forgetrace.dto.request;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;

/** Manufacturer's offer. Totals are calculated on the server - never trusted from the browser. */
@Getter
@Setter
@NoArgsConstructor
public class QuotationCreateRequest {

    @NotNull(message = "Unit price is required")
    @DecimalMin(value = "0.01", message = "Unit price must be greater than 0")
    @Digits(integer = 10, fraction = 2, message = "Use at most 2 decimals")
    private BigDecimal unitPrice;

    @NotNull(message = "Setup fee is required (use 0 if none)")
    @DecimalMin(value = "0", message = "Setup fee cannot be negative")
    @Digits(integer = 10, fraction = 2, message = "Use at most 2 decimals")
    private BigDecimal setupFee = BigDecimal.ZERO;

    /** GST % applied to (unit price x quantity + setup fee). */
    @NotNull(message = "Tax rate is required")
    @DecimalMin(value = "0", message = "Tax rate cannot be negative")
    @DecimalMax(value = "28", message = "Tax rate cannot be more than 28%")
    private BigDecimal taxRatePercent = new BigDecimal("18");

    @NotNull(message = "Lead time is required")
    @Min(value = 1, message = "Lead time must be at least 1 day")
    @Max(value = 365, message = "Lead time cannot be more than 365 days")
    private Integer leadTimeDays;

    /** Last day the offer can be accepted (end of that day, Indian time). */
    @NotNull(message = "Valid-until date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate validUntil;

    @Size(max = 2000)
    private String terms;
}