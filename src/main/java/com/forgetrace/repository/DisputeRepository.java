package com.forgetrace.repository;

import com.forgetrace.entity.Dispute;
import com.forgetrace.enums.DisputeStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DisputeRepository extends JpaRepository<Dispute, Long> {

    @EntityGraph(attributePaths = {"productionOrder", "openedBy"})
    Page<Dispute> findByStatusOrderByCreatedAtDesc(DisputeStatus status, Pageable pageable);

    List<Dispute> findByProductionOrder_IdOrderByCreatedAtDesc(Long orderId);

    @EntityGraph(attributePaths = "productionOrder")
    Page<Dispute> findByProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(Long buyerId, Pageable pageable);

    long countByStatus(DisputeStatus status);
}