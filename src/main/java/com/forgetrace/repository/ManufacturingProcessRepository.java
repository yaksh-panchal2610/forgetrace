package com.forgetrace.repository;

import com.forgetrace.entity.ManufacturingProcess;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ManufacturingProcessRepository extends JpaRepository<ManufacturingProcess, Long> {

    List<ManufacturingProcess> findByActiveTrueOrderByProcessNameAsc();

    Optional<ManufacturingProcess> findByProcessNameIgnoreCase(String processName);
}