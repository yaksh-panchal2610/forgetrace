package com.forgetrace.entity;

import com.forgetrace.enums.MeasurementResult;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "inspection_measurements")
@Getter
@Setter
@NoArgsConstructor
public class InspectionMeasurement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "inspection_id")
    private Inspection inspection;

    @Column(nullable = false, length = 100)
    private String parameterName;

    @Column(nullable = false, precision = 14, scale = 4)
    private BigDecimal expectedMin;

    @Column(nullable = false, precision = 14, scale = 4)
    private BigDecimal expectedMax;

    @Column(nullable = false, precision = 14, scale = 4)
    private BigDecimal actualValue;

    @Column(nullable = false, length = 20)
    private String unit;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private MeasurementResult result;

    @Column(length = 255)
    private String remarks;

    /** Calculates PASS/FAIL from min, max and actual. Call before saving. */
    public void evaluate() {
        this.result = MeasurementResult.evaluate(expectedMin, expectedMax, actualValue);
    }

    public boolean isPass() {
        return result == MeasurementResult.PASS;
    }
}