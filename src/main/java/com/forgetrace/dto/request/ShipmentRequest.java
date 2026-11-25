package com.forgetrace.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
public class ShipmentRequest {

    @NotNull(message = "Choose an order")
    private Long orderId;

    @NotBlank(message = "Carrier is required")
    @Size(max = 100)
    private String carrierName;

    @Size(max = 100)
    private String trackingNumber;

    @NotNull(message = "Dispatch date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate dispatchDate = LocalDate.now();

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate expectedDelivery;

    @Size(max = 160)
    private String location;

    @Size(max = 255)
    private String remarks;
}