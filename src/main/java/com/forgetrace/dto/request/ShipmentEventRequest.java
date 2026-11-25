package com.forgetrace.dto.request;

import com.forgetrace.enums.ShipmentStatus;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ShipmentEventRequest {

    @NotNull(message = "Choose a status")
    private ShipmentStatus status = ShipmentStatus.IN_TRANSIT;

    @Size(max = 160)
    private String location;

    @Size(max = 255)
    private String remarks;
}