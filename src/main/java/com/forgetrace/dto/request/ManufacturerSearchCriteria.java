package com.forgetrace.dto.request;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** Filters for the public manufacturer directory. All fields are optional. */
@Getter
@Setter
@NoArgsConstructor
public class ManufacturerSearchCriteria {

    @Size(max = 100)
    private String q;

    private Long processId;

    private Long materialId;

    @Size(max = 80)
    private String city;

    public boolean hasFilters() {
        return (q != null && !q.isBlank()) || processId != null || materialId != null
                || (city != null && !city.isBlank());
    }
}