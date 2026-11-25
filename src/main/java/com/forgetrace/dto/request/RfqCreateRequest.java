package com.forgetrace.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * New RFQ form. Tests: FT-010 (valid RFQ), FT-011 (quantity 0), FT-012 (negative quantity),
 * FT-013 (deadline in the past - checked in RfqService because it needs the time zone).
 */
@Getter
@Setter
@NoArgsConstructor
public class RfqCreateRequest {

    @NotBlank(message = "Title is required")
    @Size(max = 160)
    private String title;

    @Size(max = 4000)
    private String description;

    @NotNull(message = "Choose a process")
    private Long processId;

    @NotNull(message = "Choose a material")
    private Long materialId;

    @NotNull(message = "Quantity is required")
    @DecimalMin(value = "0.001", message = "Quantity must be greater than 0")
    @Digits(integer = 11, fraction = 3, message = "Quantity can have at most 3 decimals")
    private BigDecimal quantity;

    @NotBlank(message = "Unit is required")
    @Size(max = 20)
    private String quantityUnit = "pcs";

    /** Flexible technical specifications, e.g. Thickness = 2 mm. Stored as JSON. */
    @Valid
    @Size(max = 10, message = "Up to 10 specification rows")
    private List<SpecRow> specs = new ArrayList<>();

    @Size(max = 2000)
    private String toleranceNotes;

    @NotNull(message = "Delivery date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate deliveryDate;

    @NotBlank(message = "Delivery address is required")
    @Size(max = 500)
    private String deliveryAddress;

    /** Entered in Indian time. */
    @NotNull(message = "Quote deadline is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime quoteDeadline;

    /** Drawings: up to 5 files. */
    private List<MultipartFile> attachments = new ArrayList<>();

    @Getter
    @Setter
    @NoArgsConstructor
    public static class SpecRow {

        @Size(max = 60, message = "Specification name: max 60 characters")
        private String name;

        @Size(max = 200, message = "Specification value: max 200 characters")
        private String value;
    }
}