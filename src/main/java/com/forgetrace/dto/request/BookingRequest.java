package com.forgetrace.dto.request;

import com.forgetrace.validation.ValidDateRange;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

/** Reserve a machine for an order. Times are entered in Indian time. */
@Getter
@Setter
@NoArgsConstructor
@ValidDateRange(startField = "startAt", endField = "endAt", message = "End must be after start")
public class BookingRequest {

    @NotNull
    private Long orderId;

    @NotNull(message = "Choose a machine")
    private Long machineId;

    @NotNull(message = "Start is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startAt;

    @NotNull(message = "End is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime endAt;
}