package com.forgetrace.repository;

import com.forgetrace.entity.ShipmentEvent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShipmentEventRepository extends JpaRepository<ShipmentEvent, Long> {

    List<ShipmentEvent> findByShipment_IdOrderByEventTimeAsc(Long shipmentId);
}