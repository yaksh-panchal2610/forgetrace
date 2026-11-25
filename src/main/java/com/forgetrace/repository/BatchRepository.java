package com.forgetrace.repository;

import com.forgetrace.entity.Batch;
import com.forgetrace.enums.BatchStatus;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface BatchRepository extends JpaRepository<Batch, Long> {

    Optional<Batch> findByBatchNumber(String batchNumber);

    List<Batch> findByProductionOrder_IdOrderByCreatedAtAsc(Long productionOrderId);

    @EntityGraph(attributePaths = {"productionOrder", "productionOrder.manufacturerOrganization"})
    List<Batch> findByStatusOrderByUpdatedAtAsc(BatchStatus status);

    @EntityGraph(attributePaths = {"productionOrder", "productionOrder.manufacturerOrganization", "productionOrder.rfq"})
    List<Batch> findByStatusInOrderByUpdatedAtAsc(Collection<BatchStatus> statuses);

    @EntityGraph(attributePaths = {"productionOrder", "productionOrder.rfq", "productionOrder.buyerOrganization"})
    List<Batch> findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId);

    long countByStatus(BatchStatus status);

    @Query("""
            select sum(b.quantity) from Batch b
            where b.productionOrder.id = :orderId
              and b.status <> :excluded
            """)
    BigDecimal sumQuantityForOrder(@Param("orderId") Long orderId,
                                   @Param("excluded") BatchStatus excluded);
}