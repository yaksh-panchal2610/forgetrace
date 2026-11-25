package com.forgetrace.service;

import com.forgetrace.dto.request.AvailabilityRuleRequest;
import com.forgetrace.dto.request.MaintenanceBlockRequest;
import com.forgetrace.entity.Machine;
import com.forgetrace.entity.MachineAvailabilityRule;
import com.forgetrace.entity.MachineMaintenanceBlock;
import com.forgetrace.enums.ReservationStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.DuplicateBookingException;
import com.forgetrace.exception.MachineUnavailableException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.MachineAvailabilityRuleRepository;
import com.forgetrace.repository.MachineMaintenanceBlockRepository;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.MachineReservationRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

/**
 * Working hours, maintenance blocks, and the availability check used by machine booking (Step 7).
 * "Regular working hours alone do not prove a machine is free" - so the check also looks at
 * machine status, maintenance and existing reservations.
 */
@Service
@RequiredArgsConstructor
public class AvailabilityService {

    private static final LocalTime END_OF_DAY_MARKER = LocalTime.of(23, 59);

    private final MachineRepository machineRepository;
    private final MachineAvailabilityRuleRepository ruleRepository;
    private final MachineMaintenanceBlockRepository maintenanceRepository;
    private final MachineReservationRepository reservationRepository;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    // ---------- Pages ----------

    @Transactional(readOnly = true)
    public List<Machine> myMachines() {
        return machineRepository.findByOrganization_IdOrderByMachineNameAsc(requireManufacturerOrganization());
    }

    @Transactional(readOnly = true)
    public List<MachineAvailabilityRule> rules(Long machineId) {
        ownMachine(machineId);
        return ruleRepository.findByMachine_IdOrderByDayOfWeekAscStartTimeAsc(machineId);
    }

    @Transactional(readOnly = true)
    public List<MachineMaintenanceBlock> maintenanceBlocks(Long machineId) {
        ownMachine(machineId);
        return maintenanceRepository.findByMachine_IdOrderByStartAtAsc(machineId);
    }

    // ---------- Working hours ----------

    @Transactional
    public int addRules(AvailabilityRuleRequest request) {
        Machine machine = ownMachine(request.getMachineId());

        Set<Integer> days = new LinkedHashSet<>(request.getDays());
        if (days.stream().anyMatch(d -> d == null || d < 1 || d > 7)) {
            throw new BusinessRuleException("Days must be between Monday (1) and Sunday (7).");
        }
        if (request.getValidUntil() != null && request.getValidUntil().isBefore(request.getValidFrom())) {
            throw new BusinessRuleException("'Valid until' must be on or after 'valid from'.");
        }

        for (Integer day : days) {
            MachineAvailabilityRule rule = new MachineAvailabilityRule();
            rule.setMachine(machine);
            rule.setDayOfWeek(day);
            rule.setStartTime(request.getStartTime());
            rule.setEndTime(request.getEndTime());
            rule.setValidFrom(request.getValidFrom());
            rule.setValidUntil(request.getValidUntil());
            ruleRepository.save(rule);
        }
        auditService.record(currentUserService.requireUserId(), "AVAILABILITY_ADDED", "Machine", machine.getId(),
                days.size() + " day(s) " + request.getStartTime() + "-" + request.getEndTime());
        return days.size();
    }

    @Transactional
    public void deleteRule(Long ruleId) {
        MachineAvailabilityRule rule = ruleRepository.findById(ruleId)
                .orElseThrow(() -> new ResourceNotFoundException("Working-hours rule", ruleId));
        requireOwn(rule.getMachine());
        ruleRepository.delete(rule);
    }

    // ---------- Maintenance ----------

    @Transactional
    public void addMaintenance(MaintenanceBlockRequest request) {
        Machine machine = ownMachine(request.getMachineId());
        Instant start = request.getStartAt().atZone(zone()).toInstant();
        Instant end = request.getEndAt().atZone(zone()).toInstant();
        if (!end.isAfter(start)) {
            throw new BusinessRuleException("Maintenance end must be after its start.");
        }
        if (!reservationRepository.findOverlapping(machine.getId(), ReservationStatus.ACTIVE, start, end).isEmpty()) {
            throw new BusinessRuleException("The machine is already reserved for production during this time.");
        }

        MachineMaintenanceBlock block = new MachineMaintenanceBlock();
        block.setMachine(machine);
        block.setStartAt(start);
        block.setEndAt(end);
        block.setReason(request.getReason() == null || request.getReason().isBlank() ? null : request.getReason().trim());
        maintenanceRepository.save(block);
        auditService.record(currentUserService.requireUserId(), "MAINTENANCE_ADDED", "Machine", machine.getId(), block.getReason());
    }

    @Transactional
    public void deleteMaintenance(Long blockId) {
        MachineMaintenanceBlock block = maintenanceRepository.findById(blockId)
                .orElseThrow(() -> new ResourceNotFoundException("Maintenance block", blockId));
        requireOwn(block.getMachine());
        maintenanceRepository.delete(block);
    }

    // ---------- Availability check (used by BookingService in Step 7) ----------

    /**
     * Throws if the machine cannot be used for [start, end).
     * Order of checks: status -> working hours -> maintenance -> existing reservations.
     */
    @Transactional(readOnly = true)
    public void checkAvailability(Machine machine, Instant start, Instant end) {
        if (start == null || end == null || !end.isAfter(start)) {
            throw new BusinessRuleException("Booking end must be after its start.");
        }
        if (!machine.isBookable()) {
            throw new MachineUnavailableException("Machine '" + machine.getMachineName() + "' is "
                    + machine.getMachineStatus().getLabel().toLowerCase(Locale.ROOT) + " and cannot be booked.");
        }
        List<MachineAvailabilityRule> rules = ruleRepository.findByMachine_IdAndActiveTrue(machine.getId());
        // No rules at all = no restriction (available 24/7). Once rules exist, they must cover the booking.
        if (!rules.isEmpty() && !coveredByWorkingHours(rules, start, end, zone())) {
            throw new MachineUnavailableException("The selected time is outside the machine's working hours.");
        }
        if (!maintenanceRepository.findOverlapping(machine.getId(), start, end).isEmpty()) {
            throw new MachineUnavailableException("The machine is under maintenance during the selected time.");
        }
        if (!reservationRepository.findOverlapping(machine.getId(), ReservationStatus.ACTIVE, start, end).isEmpty()) {
            throw new DuplicateBookingException();
        }
    }

    /**
     * Splits the booking into one slice per calendar day and checks that every slice
     * fits completely inside one working-hours rule for that day.
     * A rule ending at 23:59 is treated as running until midnight.
     */
    static boolean coveredByWorkingHours(List<MachineAvailabilityRule> rules, Instant start, Instant end, ZoneId zone) {
        ZonedDateTime cursor = start.atZone(zone);
        ZonedDateTime finish = end.atZone(zone);

        while (cursor.isBefore(finish)) {
            LocalDate day = cursor.toLocalDate();
            ZonedDateTime nextMidnight = day.plusDays(1).atStartOfDay(zone);
            ZonedDateTime sliceEnd = finish.isBefore(nextMidnight) ? finish : nextMidnight;

            LocalTime from = cursor.toLocalTime();
            LocalTime to = sliceEnd.equals(nextMidnight) ? LocalTime.MAX : sliceEnd.toLocalTime();

            boolean covered = rules.stream().anyMatch(rule ->
                    rule.appliesOn(day)
                            && !from.isBefore(rule.getStartTime())
                            && !to.isAfter(effectiveEnd(rule)));
            if (!covered) {
                return false;
            }
            cursor = sliceEnd;
        }
        return true;
    }

    private static LocalTime effectiveEnd(MachineAvailabilityRule rule) {
        return rule.getEndTime().equals(END_OF_DAY_MARKER) ? LocalTime.MAX : rule.getEndTime();
    }

    // ---------- helpers ----------

    private ZoneId zone() {
        return ZoneId.of(displayZone);
    }

    private Machine ownMachine(Long machineId) {
        Long orgId = requireManufacturerOrganization();
        return machineRepository.findByIdAndOrganization_Id(machineId, orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Machine", machineId));
    }

    private void requireOwn(Machine machine) {
        Long orgId = requireManufacturerOrganization();
        if (!machine.getOrganization().getId().equals(orgId)) {
            throw new ResourceNotFoundException("Machine", machine.getId());
        }
    }

    private Long requireManufacturerOrganization() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }
}