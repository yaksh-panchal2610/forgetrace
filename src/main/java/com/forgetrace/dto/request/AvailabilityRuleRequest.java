package com.forgetrace.dto.request;

import com.forgetrace.validation.ValidDateRange;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/** Working hours for one or more days of the week (1 = Monday ... 7 = Sunday). */
@Getter
@Setter
@NoArgsConstructor
@ValidDateRange(startField = "startTime", endField = "endTime", message = "End time must be after start time")
public class AvailabilityRuleRequest {

    @NotNull
    private Long machineId;

    @NotEmpty(message = "Select at least one day")
    private List<Integer> days = new ArrayList<>(List.of(1, 2, 3, 4, 5));

    @NotNull(message = "Start time is required")
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime startTime = LocalTime.of(9, 0);

    @NotNull(message = "End time is required")
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime endTime = LocalTime.of(18, 0);

    @NotNull(message = "Valid-from date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate validFrom = LocalDate.now();

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate validUntil;
}