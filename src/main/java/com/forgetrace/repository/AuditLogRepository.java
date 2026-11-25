package com.forgetrace.repository;

import com.forgetrace.entity.AuditLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.Instant;
import java.util.List;

public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {

    @EntityGraph(attributePaths = "actorUser")
    Page<AuditLog> findAllByOrderByCreatedAtDesc(Pageable pageable);

    /** Used by AuditLogCsvExporter to save a date range of logs to a CSV file. */
    @EntityGraph(attributePaths = "actorUser")
    List<AuditLog> findByCreatedAtBetweenOrderByCreatedAtAsc(Instant from, Instant to);

    Page<AuditLog> findByEntityTypeAndEntityIdOrderByCreatedAtDesc(String entityType, Long entityId, Pageable pageable);
}