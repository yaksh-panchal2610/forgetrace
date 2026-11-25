package com.forgetrace.repository;

import com.forgetrace.entity.Machine;
import com.forgetrace.enums.MachineStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MachineRepository extends JpaRepository<Machine, Long> {

    List<Machine> findByOrganization_IdOrderByMachineNameAsc(Long organizationId);

    /** Ownership check: only returns the machine if it belongs to this organization. */
    Optional<Machine> findByIdAndOrganization_Id(Long id, Long organizationId);

    boolean existsByOrganization_IdAndSerialNumber(Long organizationId, String serialNumber);

    long countByOrganization_IdAndMachineStatus(Long organizationId, MachineStatus status);
}