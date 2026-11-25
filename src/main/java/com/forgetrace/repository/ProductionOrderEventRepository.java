package com.forgetrace.repository;

import com.forgetrace.entity.ProductionOrderEvent;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductionOrderEventRepository extends JpaRepository<ProductionOrderEvent, Long> {

    @EntityGraph(attributePaths = "updatedBy")
    List<ProductionOrderEvent> findByProductionOrder_IdOrderByCreatedAtAsc(Long productionOrderId);
}