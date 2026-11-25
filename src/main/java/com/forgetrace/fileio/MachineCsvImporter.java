package com.forgetrace.fileio;

import com.forgetrace.dto.request.MachineRequest;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.enums.MachineStatus;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Loads machines from a CSV file (and writes them back out for export).
 * Processes and materials are written by NAME, separated by ';', e.g. "CNC Machining;Welding".
 * Only names the manufacturer already offers are accepted.
 */
public class MachineCsvImporter extends AbstractCsvHandler<MachineRequest> {

    public static final List<String> HEADERS = List.of(
            "machine_name", "machine_type", "model_number", "serial_number",
            "capacity_value", "capacity_unit", "status", "location", "processes", "materials");

    private final Map<String, Long> processIdsByName = new HashMap<>();
    private final Map<String, Long> materialIdsByName = new HashMap<>();
    private final Map<Long, String> processNamesById = new HashMap<>();
    private final Map<Long, String> materialNamesById = new HashMap<>();

    public MachineCsvImporter(Collection<ManufacturingProcess> allowedProcesses, Collection<Material> allowedMaterials) {
        for (ManufacturingProcess p : allowedProcesses) {
            processIdsByName.put(p.getProcessName().toLowerCase(Locale.ROOT), p.getId());
            processNamesById.put(p.getId(), p.getProcessName());
        }
        for (Material m : allowedMaterials) {
            materialIdsByName.put(m.getMaterialName().toLowerCase(Locale.ROOT), m.getId());
            materialNamesById.put(m.getId(), m.getMaterialName());
        }
    }

    @Override
    protected List<String> headers() {
        return HEADERS;
    }

    @Override
    protected List<String> requiredHeaders() {
        return List.of("machine_name", "machine_type", "processes", "materials");
    }

    @Override
    protected MachineRequest fromRow(Map<String, String> row) {
        MachineRequest request = new MachineRequest();
        request.setMachineName(blankToNull(row.get("machine_name")));
        request.setMachineType(blankToNull(row.get("machine_type")));
        request.setModelNumber(blankToNull(row.get("model_number")));
        request.setSerialNumber(blankToNull(row.get("serial_number")));
        request.setCapacityValue(parseDecimal(row.get("capacity_value")));
        request.setCapacityUnit(blankToNull(row.get("capacity_unit")));
        request.setMachineStatus(parseStatus(row.get("status")));
        request.setLocation(blankToNull(row.get("location")));
        request.setProcessIds(lookup(row.get("processes"), processIdsByName, "process"));
        request.setMaterialIds(lookup(row.get("materials"), materialIdsByName, "material"));
        return request;
    }

    @Override
    protected List<String> toRow(MachineRequest m) {
        return List.of(
                nullToEmpty(m.getMachineName()),
                nullToEmpty(m.getMachineType()),
                nullToEmpty(m.getModelNumber()),
                nullToEmpty(m.getSerialNumber()),
                m.getCapacityValue() == null ? "" : m.getCapacityValue().toPlainString(),
                nullToEmpty(m.getCapacityUnit()),
                m.getMachineStatus() == null ? "" : m.getMachineStatus().name(),
                nullToEmpty(m.getLocation()),
                names(m.getProcessIds(), processNamesById),
                names(m.getMaterialIds(), materialNamesById));
    }

    // ---------- helpers ----------

    private static BigDecimal parseDecimal(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return new BigDecimal(value.trim());
        } catch (NumberFormatException ex) {
            throw new CsvRowException("capacity_value '" + value + "' is not a number");
        }
    }

    private static MachineStatus parseStatus(String value) {
        if (value == null || value.isBlank()) {
            return MachineStatus.ACTIVE;
        }
        try {
            return MachineStatus.valueOf(value.trim().toUpperCase(Locale.ROOT));
        } catch (IllegalArgumentException ex) {
            throw new CsvRowException("status '" + value + "' must be one of: "
                    + Arrays.stream(MachineStatus.values()).map(Enum::name).collect(Collectors.joining(", ")));
        }
    }

    private static List<Long> lookup(String cell, Map<String, Long> idsByName, String kind) {
        List<Long> ids = new ArrayList<>();
        if (cell == null || cell.isBlank()) {
            return ids;
        }
        for (String rawName : cell.split(";")) {
            String name = rawName.trim();
            if (name.isEmpty()) {
                continue;
            }
            Long id = idsByName.get(name.toLowerCase(Locale.ROOT));
            if (id == null) {
                throw new CsvRowException("Unknown " + kind + " '" + name
                        + "'. Use one your company offers (see Profile & company).");
            }
            if (!ids.contains(id)) {
                ids.add(id);
            }
        }
        return ids;
    }

    private static String names(List<Long> ids, Map<Long, String> namesById) {
        if (ids == null) {
            return "";
        }
        return ids.stream().map(namesById::get).filter(n -> n != null).sorted().collect(Collectors.joining(";"));
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private static String nullToEmpty(String value) {
        return value == null ? "" : value;
    }
}