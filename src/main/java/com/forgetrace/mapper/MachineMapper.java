package com.forgetrace.mapper;

import com.forgetrace.dto.request.MachineRequest;
import com.forgetrace.dto.response.MachineView;
import com.forgetrace.entity.Machine;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;

@Component
public class MachineMapper {

    public MachineView toView(Machine m) {
        return new MachineView(
                m.getId(), m.getMachineName(), m.getMachineType(), m.getModelNumber(), m.getSerialNumber(),
                m.getCapacityValue(), m.getCapacityUnit(), m.getMachineStatus(), m.getLocation(),
                m.getProcesses().stream().map(ManufacturingProcess::getProcessName).sorted().toList(),
                m.getMaterials().stream().map(Material::getMaterialName).sorted().toList());
    }

    public MachineRequest toRequest(Machine m) {
        MachineRequest r = new MachineRequest();
        r.setMachineName(m.getMachineName());
        r.setMachineType(m.getMachineType());
        r.setModelNumber(m.getModelNumber());
        r.setSerialNumber(m.getSerialNumber());
        r.setCapacityValue(m.getCapacityValue());
        r.setCapacityUnit(m.getCapacityUnit());
        r.setMachineStatus(m.getMachineStatus());
        r.setLocation(m.getLocation());
        r.setProcessIds(new ArrayList<>(m.getProcesses().stream().map(ManufacturingProcess::getId).toList()));
        r.setMaterialIds(new ArrayList<>(m.getMaterials().stream().map(Material::getId).toList()));
        return r;
    }

    public void apply(MachineRequest r, Machine m,
                      Collection<ManufacturingProcess> processes, Collection<Material> materials) {
        m.setMachineName(r.getMachineName().trim());
        m.setMachineType(r.getMachineType().trim());
        m.setModelNumber(blankToNull(r.getModelNumber()));
        m.setSerialNumber(blankToNull(r.getSerialNumber()));
        m.setCapacityValue(r.getCapacityValue());
        m.setCapacityUnit(blankToNull(r.getCapacityUnit()));
        m.setMachineStatus(r.getMachineStatus());
        m.setLocation(blankToNull(r.getLocation()));
        m.getProcesses().clear();
        m.getProcesses().addAll(processes);
        m.getMaterials().clear();
        m.getMaterials().addAll(materials);
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}