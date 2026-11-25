package com.forgetrace.dto.request;

import com.forgetrace.validation.ValidDateRange;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

/** A period when the machine cannot be booked. Times are entered in Indian time. */
@Getter
@Setter
@NoArgsConstructor
@ValidDateRange(startField = "startAt", endField = "endAt", message = "End must be after start")
public class MaintenanceBlockRequest {

    @NotNull
    private Long machineId;

    @NotNull(message = "Start is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startAt;

    @NotNull(message = "End is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime endAt;

    @Size(max = 255)
    private String reason;
}