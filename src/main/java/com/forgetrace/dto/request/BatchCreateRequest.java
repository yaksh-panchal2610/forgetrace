package com.forgetrace.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
public class BatchCreateRequest {

    @NotNull(message = "Choose an order")
    private Long orderId;

    @NotNull(message = "Quantity is required")
    @DecimalMin(value = "0.001", message = "Quantity must be greater than 0")
    @Digits(integer = 11, fraction = 3, message = "Quantity can have at most 3 decimals")
    private BigDecimal quantity;

    @NotNull(message = "Manufacture date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate manufactureDate = LocalDate.now();
}