package com.forgetrace.repository;

import com.forgetrace.entity.Shipment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ShipmentRepository extends JpaRepository<Shipment, Long> {

    @EntityGraph(attributePaths = "events")
    List<Shipment> findByProductionOrder_IdOrderByCreatedAtDesc(Long productionOrderId);

    @EntityGraph(attributePaths = "productionOrder")
    Page<Shipment> findByProductionOrder_ManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId, Pageable pageable);

    Optional<Shipment> findByTrackingNumber(String trackingNumber);
}