package com.forgetrace.repository;

import com.forgetrace.entity.Inspection;
import com.forgetrace.enums.InspectionStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface InspectionRepository extends JpaRepository<Inspection, Long> {

    @EntityGraph(attributePaths = "inspector")
    List<Inspection> findByBatch_IdOrderByCreatedAtDesc(Long batchId);

    @EntityGraph(attributePaths = "batch")
    Page<Inspection> findByInspector_IdOrderByCreatedAtDesc(Long inspectorId, Pageable pageable);

    @EntityGraph(attributePaths = {"batch", "inspector", "measurements"})
    Optional<Inspection> findWithDetailsById(Long id);

    @EntityGraph(attributePaths = "measurements")
    Optional<Inspection> findFirstByBatch_IdAndStatusOrderByInspectedAtDesc(Long batchId, InspectionStatus status);

    long countByInspector_IdAndStatus(Long inspectorId, InspectionStatus status);

    long countByStatus(InspectionStatus status);
}