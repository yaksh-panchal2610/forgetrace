package com.forgetrace.dto.request;

import com.forgetrace.enums.MachineStatus;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/** Used by the machine form AND by each row of the CSV import. */
@Getter
@Setter
@NoArgsConstructor
public class MachineRequest {

    @NotBlank(message = "Machine name is required")
    @Size(max = 120)
    private String machineName;

    @NotBlank(message = "Machine type is required")
    @Size(max = 80)
    private String machineType;

    @Size(max = 80)
    private String modelNumber;

    @Size(max = 80)
    private String serialNumber;

    @DecimalMin(value = "0", inclusive = false, message = "Capacity must be greater than 0")
    @Digits(integer = 10, fraction = 2, message = "Capacity can have at most 2 decimals")
    private BigDecimal capacityValue;

    @Size(max = 30)
    private String capacityUnit;

    @NotNull(message = "Status is required")
    private MachineStatus machineStatus = MachineStatus.ACTIVE;

    @Size(max = 160)
    private String location;

    @NotEmpty(message = "Select at least one process")
    private List<Long> processIds = new ArrayList<>();

    @NotEmpty(message = "Select at least one material")
    private List<Long> materialIds = new ArrayList<>();
}