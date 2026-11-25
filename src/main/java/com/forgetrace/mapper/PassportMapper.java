package com.forgetrace.mapper;

import com.forgetrace.dto.response.InspectionView;
import com.forgetrace.dto.response.PassportView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.Inspection;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.ProductPassport;
import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.BatchStatus;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PassportMapper {

    public PassportView toView(ProductPassport passport, Inspection inspection) {
        Batch batch = passport.getBatch();
        Rfq rfq = batch.getProductionOrder().getRfq();
        Organization manufacturer = batch.getProductionOrder().getManufacturerOrganization();
        List<InspectionView.MeasurementRow> measurements = inspection == null ? List.of()
                : inspection.getMeasurements().stream()
                .map(m -> new InspectionView.MeasurementRow(m.getParameterName(), m.getExpectedMin(), m.getExpectedMax(),
                        m.getActualValue(), m.getUnit(), m.getResult(), null))
                .toList();
        String location = manufacturer.getCity() == null ? manufacturer.getState()
                : manufacturer.getCity() + (manufacturer.getState() == null ? "" : ", " + manufacturer.getState());
        return new PassportView(
                passport.getPublicToken(),
                batch.getBatchNumber(),
                batch.getQuantity(),
                rfq.getQuantityUnit(),
                batch.getManufactureDate(),
                manufacturer.getDisplayName(),
                location,
                rfq.getProcess().getProcessName(),
                rfq.getMaterial().getMaterialName(),
                inspection == null ? null : inspection.getInspectedAt(),
                inspection == null ? null : inspection.getStatus(),
                measurements,
                passport.getPublishedAt(),
                !passport.isPubliclyVisible(),
                batch.getStatus() == BatchStatus.RECALLED);
    }
}