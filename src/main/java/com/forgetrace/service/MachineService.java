package com.forgetrace.service;

import com.forgetrace.dto.request.MachineRequest;
import com.forgetrace.dto.response.CsvImportResult;
import com.forgetrace.dto.response.MachineView;
import com.forgetrace.entity.Machine;
import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.enums.MachineStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.FileValidationException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.fileio.AbstractCsvHandler;
import com.forgetrace.fileio.MachineCsvImporter;
import com.forgetrace.mapper.MachineMapper;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.ManufacturerProfileRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/** Manufacturer's own machines: create, edit, change status, CSV import and export. */
@Slf4j
@Service
@RequiredArgsConstructor
public class MachineService {

    private final MachineRepository machineRepository;
    private final ManufacturerProfileRepository profileRepository;
    private final OrganizationRepository organizationRepository;
    private final MachineMapper mapper;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;
    private final Validator validator;

    /** The processes and materials this manufacturer offers - machines can only use these. */
    public record Capabilities(List<ManufacturingProcess> processes, List<Material> materials) {
    }

    @Transactional(readOnly = true)
    public List<MachineView> listMine() {
        Long orgId = requireManufacturerOrganization();
        return machineRepository.findByOrganization_IdOrderByMachineNameAsc(orgId).stream()
                .map(mapper::toView)
                .toList();
    }

    @Transactional(readOnly = true)
    public Capabilities capabilities() {
        ManufacturerProfile profile = profile(requireManufacturerOrganization());
        return new Capabilities(
                profile.getProcesses().stream().sorted(Comparator.comparing(ManufacturingProcess::getProcessName)).toList(),
                profile.getMaterials().stream().sorted(Comparator.comparing(Material::getMaterialName)).toList());
    }

    @Transactional(readOnly = true)
    public MachineRequest editForm(Long machineId) {
        return mapper.toRequest(ownMachine(machineId));
    }

    @Transactional
    public Machine create(MachineRequest request) {
        Long orgId = requireManufacturerOrganization();
        Machine machine = new Machine();
        machine.setOrganization(organizationRepository.getReferenceById(orgId));
        applyChecked(request, machine, orgId, profile(orgId));
        machineRepository.save(machine);
        auditService.record(currentUserService.requireUserId(), "MACHINE_CREATED", "Machine", machine.getId(), machine.getMachineName());
        return machine;
    }

    @Transactional
    public void update(Long machineId, MachineRequest request) {
        Long orgId = requireManufacturerOrganization();
        Machine machine = ownMachine(machineId);
        applyChecked(request, machine, orgId, profile(orgId));
        auditService.record(currentUserService.requireUserId(), "MACHINE_UPDATED", "Machine", machineId, machine.getMachineName());
    }

    @Transactional
    public void changeStatus(Long machineId, MachineStatus status) {
        Machine machine = ownMachine(machineId);
        machine.setMachineStatus(status);
        auditService.record(currentUserService.requireUserId(), "MACHINE_STATUS_CHANGED", "Machine", machineId, status.name());
    }

    // ---------- CSV import / export ----------

    @Transactional
    public CsvImportResult importCsv(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new FileValidationException("Please choose a CSV file.");
        }
        String name = file.getOriginalFilename() == null ? "" : file.getOriginalFilename().toLowerCase(Locale.ROOT);
        if (!name.endsWith(".csv")) {
            throw new FileValidationException("Only .csv files can be imported.");
        }

        Long orgId = requireManufacturerOrganization();
        ManufacturerProfile profile = profile(orgId);
        MachineCsvImporter importer = new MachineCsvImporter(profile.getProcesses(), profile.getMaterials());

        AbstractCsvHandler.ParseResult<MachineRequest> parsed;
        try (InputStream in = file.getInputStream()) {
            parsed = importer.read(in);
        } catch (IOException ex) {
            throw new FileValidationException("The CSV file could not be read.");
        }

        List<CsvImportResult.RowError> errors = new ArrayList<>(parsed.errors());
        Set<String> serialsInFile = new HashSet<>();
        int imported = 0;

        for (AbstractCsvHandler.ParsedRow<MachineRequest> row : parsed.rows()) {
            MachineRequest request = row.value();

            // Same validation rules as the web form
            Set<ConstraintViolation<MachineRequest>> violations = validator.validate(request);
            if (!violations.isEmpty()) {
                String message = violations.stream()
                        .map(v -> v.getPropertyPath() + ": " + v.getMessage())
                        .sorted()
                        .collect(Collectors.joining("; "));
                errors.add(new CsvImportResult.RowError(row.lineNumber(), message));
                continue;
            }
            if (request.getSerialNumber() != null && !serialsInFile.add(request.getSerialNumber().trim())) {
                errors.add(new CsvImportResult.RowError(row.lineNumber(), "Serial number repeated in this file"));
                continue;
            }
            try {
                Machine machine = new Machine();
                machine.setOrganization(organizationRepository.getReferenceById(orgId));
                applyChecked(request, machine, orgId, profile);
                machineRepository.save(machine);
                imported++;
            } catch (BusinessRuleException ex) {
                errors.add(new CsvImportResult.RowError(row.lineNumber(), ex.getMessage()));
            }
        }

        errors.sort(Comparator.comparingInt(CsvImportResult.RowError::lineNumber));
        int totalRows = parsed.rows().size() + parsed.errors().size();
        auditService.record(currentUserService.requireUserId(), "MACHINES_IMPORTED", "Organization", orgId,
                imported + " imported, " + errors.size() + " rejected from " + file.getOriginalFilename());
        log.info("CSV import for organization {}: {} imported, {} rejected", orgId, imported, errors.size());
        return new CsvImportResult(totalRows, imported, errors);
    }

    @Transactional(readOnly = true)
    public void exportMine(Writer writer) throws IOException {
        Long orgId = requireManufacturerOrganization();
        ManufacturerProfile profile = profile(orgId);
        MachineCsvImporter exporter = new MachineCsvImporter(profile.getProcesses(), profile.getMaterials());
        List<MachineRequest> rows = machineRepository.findByOrganization_IdOrderByMachineNameAsc(orgId).stream()
                .map(mapper::toRequest)
                .toList();
        exporter.write(writer, rows);
    }

    // ---------- helpers ----------

    /** Business rules shared by the form and the CSV import. */
    private void applyChecked(MachineRequest request, Machine machine, Long orgId, ManufacturerProfile profile) {
        Set<Long> processIds = new HashSet<>(request.getProcessIds());
        Set<Long> materialIds = new HashSet<>(request.getMaterialIds());

        List<ManufacturingProcess> processes = profile.getProcesses().stream()
                .filter(p -> processIds.contains(p.getId())).toList();
        List<Material> materials = profile.getMaterials().stream()
                .filter(m -> materialIds.contains(m.getId())).toList();

        if (processes.size() != processIds.size() || materials.size() != materialIds.size()) {
            throw new BusinessRuleException("A machine can only use processes and materials your company offers. "
                    + "Add them in Profile & company first.");
        }
        if (request.getCapacityValue() != null && (request.getCapacityUnit() == null || request.getCapacityUnit().isBlank())) {
            throw new BusinessRuleException("Enter a unit for the capacity (for example mm, kg, parts/hour).");
        }

        String serial = request.getSerialNumber() == null || request.getSerialNumber().isBlank()
                ? null : request.getSerialNumber().trim();
        if (serial != null && !Objects.equals(serial, machine.getSerialNumber())
                && machineRepository.existsByOrganization_IdAndSerialNumber(orgId, serial)) {
            throw new BusinessRuleException("Another machine already uses serial number '" + serial + "'.");
        }

        mapper.apply(request, machine, processes, materials);
    }

    private Machine ownMachine(Long machineId) {
        Long orgId = requireManufacturerOrganization();
        // Another company's machine looks exactly like a missing one - no information leak
        return machineRepository.findByIdAndOrganization_Id(machineId, orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Machine", machineId));
    }

    private ManufacturerProfile profile(Long orgId) {
        return profileRepository.findById(orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Manufacturer profile", orgId));
    }

    private Long requireManufacturerOrganization() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }
}