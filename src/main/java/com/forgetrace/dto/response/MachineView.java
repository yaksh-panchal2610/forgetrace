package com.forgetrace.dto.response;

import com.forgetrace.enums.MachineStatus;

import java.math.BigDecimal;
import java.util.List;

/** One row in the machine list. */
public record MachineView(
        Long id,
        String machineName,
        String machineType,
        String modelNumber,
        String serialNumber,
        BigDecimal capacityValue,
        String capacityUnit,
        MachineStatus status,
        String location,
        List<String> processes,
        List<String> materials
) {
}