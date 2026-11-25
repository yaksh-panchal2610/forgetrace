package com.forgetrace.repository;

import com.forgetrace.entity.ProductPassport;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProductPassportRepository extends JpaRepository<ProductPassport, Long> {

    @EntityGraph(attributePaths = {"batch", "batch.productionOrder", "batch.productionOrder.manufacturerOrganization"})
    Optional<ProductPassport> findByPublicToken(UUID publicToken);

    Optional<ProductPassport> findByBatch_Id(Long batchId);

    boolean existsByBatch_Id(Long batchId);

    @EntityGraph(attributePaths = {"batch", "batch.productionOrder"})
    List<ProductPassport> findByBatch_ProductionOrder_BuyerOrganization_IdOrderByCreatedAtDesc(Long buyerOrganizationId);
}