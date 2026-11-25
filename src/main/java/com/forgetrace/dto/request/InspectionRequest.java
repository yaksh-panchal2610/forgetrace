package com.forgetrace.dto.request;

import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.InspectionType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class InspectionRequest {

    @NotNull(message = "Choose an inspection type")
    private InspectionType inspectionType = InspectionType.FINAL;

    @NotNull(message = "Choose a decision")
    private InspectionStatus decision;

    @Size(max = 4000)
    private String findings;

    @Valid
    @Size(max = 30, message = "Up to 30 measurements")
    private List<MeasurementRequest> measurements = new ArrayList<>();
}