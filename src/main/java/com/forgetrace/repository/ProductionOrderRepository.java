package com.forgetrace.repository;

import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.OrderStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface ProductionOrderRepository extends JpaRepository<ProductionOrder, Long> {

    Optional<ProductionOrder> findByOrderNumber(String orderNumber);

    @EntityGraph(attributePaths = {"buyerOrganization", "manufacturerOrganization", "rfq", "acceptedQuotation"})
    Optional<ProductionOrder> findWithDetailsById(Long id);

    boolean existsByRfq_Id(Long rfqId);

    @EntityGraph(attributePaths = {"manufacturerOrganization", "rfq"})
    Page<ProductionOrder> findByBuyerOrganization_IdOrderByCreatedAtDesc(Long buyerId, Pageable pageable);

    @EntityGraph(attributePaths = {"buyerOrganization", "rfq"})
    Page<ProductionOrder> findByManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId, Pageable pageable);

    /** Production board: this manufacturer's orders in the given statuses, earliest due first. */
    @EntityGraph(attributePaths = {"buyerOrganization", "rfq"})
    List<ProductionOrder> findByManufacturerOrganization_IdAndStatusInOrderByExpectedCompletionAsc(
            Long manufacturerId, Collection<OrderStatus> statuses);

    @EntityGraph(attributePaths = {"buyerOrganization", "manufacturerOrganization"})
    Page<ProductionOrder> findAllByOrderByCreatedAtDesc(Pageable pageable);

    long countByStatus(OrderStatus status);

    long countByBuyerOrganization_IdAndStatusIn(Long buyerId, Collection<OrderStatus> statuses);

    long countByManufacturerOrganization_IdAndStatusIn(Long manufacturerId, Collection<OrderStatus> statuses);
}