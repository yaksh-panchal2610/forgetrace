package com.forgetrace.repository;

import com.forgetrace.entity.InspectionMeasurement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InspectionMeasurementRepository extends JpaRepository<InspectionMeasurement, Long> {

    List<InspectionMeasurement> findByInspection_Id(Long inspectionId);
}