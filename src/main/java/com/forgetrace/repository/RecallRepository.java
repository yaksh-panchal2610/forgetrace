package com.forgetrace.repository;

import com.forgetrace.entity.Recall;
import com.forgetrace.enums.RecallStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RecallRepository extends JpaRepository<Recall, Long> {

    List<Recall> findByBatch_Id(Long batchId);

    @EntityGraph(attributePaths = {"batch", "initiatedBy"})
    Page<Recall> findAllByOrderByCreatedAtDesc(Pageable pageable);

    long countByStatusNot(RecallStatus status);
}