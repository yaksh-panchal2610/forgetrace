package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.InspectionType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "inspections")
@Getter
@Setter
@NoArgsConstructor
public class Inspection extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "batch_id")
    private Batch batch;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "inspector_user_id")
    private User inspector;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private InspectionType inspectionType = InspectionType.FINAL;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private InspectionStatus status = InspectionStatus.PENDING;

    @Column(columnDefinition = "text")
    private String findings;

    private Instant inspectedAt;

    @OneToMany(mappedBy = "inspection", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<InspectionMeasurement> measurements = new ArrayList<>();

    public void addMeasurement(InspectionMeasurement measurement) {
        measurement.setInspection(this);
        measurements.add(measurement);
    }

    public boolean allMeasurementsPass() {
        return !measurements.isEmpty() && measurements.stream().allMatch(InspectionMeasurement::isPass);
    }
}