package com.forgetrace.repository;

import com.forgetrace.entity.MachineAvailabilityRule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MachineAvailabilityRuleRepository extends JpaRepository<MachineAvailabilityRule, Long> {

    List<MachineAvailabilityRule> findByMachine_IdAndActiveTrue(Long machineId);

    List<MachineAvailabilityRule> findByMachine_IdOrderByDayOfWeekAscStartTimeAsc(Long machineId);
}