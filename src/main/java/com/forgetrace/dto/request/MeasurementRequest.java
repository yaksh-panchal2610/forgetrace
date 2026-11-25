package com.forgetrace.dto.request;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
public class MeasurementRequest {

    @Size(max = 100)
    private String parameterName;

    @Digits(integer = 10, fraction = 4)
    private BigDecimal expectedMin;

    @Digits(integer = 10, fraction = 4)
    private BigDecimal expectedMax;

    @Digits(integer = 10, fraction = 4)
    private BigDecimal actualValue;

    @Size(max = 20)
    private String unit;

    @Size(max = 255)
    private String remarks;

    public boolean isBlank() {
        return (parameterName == null || parameterName.isBlank())
                && expectedMin == null && expectedMax == null && actualValue == null
                && (unit == null || unit.isBlank());
    }
}