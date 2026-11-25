package com.forgetrace.service;

import com.forgetrace.dto.request.InspectionRequest;
import com.forgetrace.dto.request.MeasurementRequest;
import com.forgetrace.dto.response.BatchView;
import com.forgetrace.dto.response.InspectionView;
import com.forgetrace.dto.response.InspectorDashboardView;
import com.forgetrace.dto.response.RfqDetailView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.Inspection;
import com.forgetrace.entity.InspectionMeasurement;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.RfqMapper;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.InspectionRepository;
import com.forgetrace.repository.RfqAttachmentRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InspectionService {

    private final InspectionRepository inspectionRepository;
    private final BatchRepository batchRepository;
    private final RfqAttachmentRepository attachmentRepository;
    private final UserRepository userRepository;
    private final BatchService batchService;
    private final PassportService passportService;
    private final NotificationService notificationService;
    private final RfqMapper rfqMapper;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Transactional(readOnly = true)
    public InspectorDashboardView dashboard() {
        requireInspector();
        Long me = currentUserService.requireUserId();
        List<BatchView> queue = batchService.inspectionQueue();
        return new InspectorDashboardView(
                batchRepository.countByStatus(BatchStatus.AWAITING_INSPECTION),
                batchRepository.countByStatus(BatchStatus.ON_HOLD),
                inspectionRepository.countByInspector_IdAndStatus(me, InspectionStatus.PASSED),
                inspectionRepository.countByInspector_IdAndStatus(me, InspectionStatus.FAILED),
                inspectionRepository.countByInspector_IdAndStatus(me, InspectionStatus.ON_HOLD),
                queue.stream().limit(8).toList());
    }

    @Transactional(readOnly = true)
    public BatchView batch(Long batchId) {
        requireInspector();
        return batchService.view(loadBatch(batchId));
    }

    @Transactional(readOnly = true)
    public RfqDetailView requirementsForBatch(Long batchId) {
        requireInspector();
        Batch batch = loadBatch(batchId);
        var rfq = batch.getProductionOrder().getRfq();
        return rfqMapper.toDetail(rfq, attachmentRepository.findByRfq_Id(rfq.getId()), Instant.now());
    }

    @Transactional(readOnly = true)
    public List<InspectionView> inspectionsForBatch(Long batchId) {
        requireInspector();
        return inspectionRepository.findByBatch_IdOrderByCreatedAtDesc(batchId).stream().map(this::toView).toList();
    }

    @Transactional
    public Inspection submit(Long batchId, InspectionRequest form) {
        requireInspector();
        Long inspectorId = currentUserService.requireUserId();
        Batch batch = loadBatch(batchId);
        if (batch.getStatus() != BatchStatus.AWAITING_INSPECTION && batch.getStatus() != BatchStatus.ON_HOLD) {
            throw new BusinessRuleException("This batch is not waiting for inspection.");
        }
        InspectionStatus decision = form.getDecision();
        if (decision == null || decision == InspectionStatus.PENDING) {
            throw new BusinessRuleException("Choose Approve, Reject or Hold.");
        }

        List<MeasurementRequest> rows = new ArrayList<>();
        for (MeasurementRequest row : form.getMeasurements()) {
            if (row != null && !row.isBlank()) {
                rows.add(row);
            }
        }
        for (int i = 0; i < rows.size(); i++) {
            MeasurementRequest r = rows.get(i);
            String label = "Measurement " + (i + 1);
            if (r.getParameterName() == null || r.getParameterName().isBlank()) {
                throw new BusinessRuleException(label + ": parameter name is required.");
            }
            if (r.getExpectedMin() == null || r.getExpectedMax() == null || r.getActualValue() == null) {
                throw new BusinessRuleException(label + " (" + r.getParameterName() + "): min, max and actual are required.");
            }
            if (r.getExpectedMax().compareTo(r.getExpectedMin()) < 0) {
                throw new BusinessRuleException(label + " (" + r.getParameterName() + "): max must be greater than or equal to min.");
            }
            if (r.getUnit() == null || r.getUnit().isBlank()) {
                throw new BusinessRuleException(label + " (" + r.getParameterName() + "): unit is required.");
            }
        }

        Inspection inspection = new Inspection();
        inspection.setBatch(batch);
        inspection.setInspector(userRepository.getReferenceById(inspectorId));
        inspection.setInspectionType(form.getInspectionType());
        inspection.setFindings(form.getFindings() == null || form.getFindings().isBlank() ? null : form.getFindings().trim());
        inspection.setInspectedAt(Instant.now());
        for (MeasurementRequest r : rows) {
            InspectionMeasurement m = new InspectionMeasurement();
            m.setParameterName(r.getParameterName().trim());
            m.setExpectedMin(r.getExpectedMin());
            m.setExpectedMax(r.getExpectedMax());
            m.setActualValue(r.getActualValue());
            m.setUnit(r.getUnit().trim());
            m.setRemarks(r.getRemarks() == null || r.getRemarks().isBlank() ? null : r.getRemarks().trim());
            m.evaluate();
            inspection.addMeasurement(m);
        }

        long failed = inspection.getMeasurements().stream().filter(m -> !m.isPass()).count();
        if (decision == InspectionStatus.PASSED) {
            if (rows.isEmpty()) {
                throw new BusinessRuleException("Record at least one measurement before approving.");
            }
            if (failed > 0) {
                throw new BusinessRuleException("The batch cannot be approved: " + failed + " measurement(s) are out of tolerance.");
            }
        }
        inspection.setStatus(decision);
        inspectionRepository.save(inspection);

        BatchStatus target = switch (decision) {
            case PASSED -> BatchStatus.APPROVED;
            case FAILED -> BatchStatus.REJECTED;
            default -> BatchStatus.ON_HOLD;
        };
        if (batch.getStatus() != target) {
            if (!batch.getStatus().canTransitionTo(target)) {
                throw new BusinessRuleException("A batch cannot move from '" + batch.getStatus().getLabel()
                        + "' to '" + target.getLabel() + "'.");
            }
            batch.setStatus(target);
        }

        Long manufacturerId = batch.getProductionOrder().getManufacturerOrganization().getId();
        String summary = "Batch " + batch.getBatchNumber() + ": " + target.getLabel()
                + (failed > 0 ? " (" + failed + " measurement(s) out of tolerance)" : "");
        notificationService.notifyOrganization(manufacturerId, "Inspection result: " + target.getLabel(), summary,
                "/manufacturer/batches?orderId=" + batch.getProductionOrder().getId());
        if (target == BatchStatus.APPROVED) {
            passportService.createForBatch(batch);
            notificationService.notifyOrganization(batch.getProductionOrder().getBuyerOrganization().getId(),
                    "Batch approved: " + batch.getBatchNumber(),
                    "A quality-approved batch for order " + batch.getProductionOrder().getOrderNumber()
                            + " now has a product passport.", "/buyer/passports");
        }
        auditService.record(inspectorId, "INSPECTION_RECORDED", "Batch", batchId, decision + ", " + rows.size() + " measurement(s)");
        return inspection;
    }

    @Transactional(readOnly = true)
    public InspectionView detail(Long inspectionId) {
        requireInspector();
        return inspectionRepository.findWithDetailsById(inspectionId)
                .map(this::toView)
                .orElseThrow(() -> new ResourceNotFoundException("Inspection", inspectionId));
    }

    @Transactional(readOnly = true)
    public Page<InspectionView> myHistory(int page) {
        requireInspector();
        return inspectionRepository.findByInspector_IdOrderByCreatedAtDesc(currentUserService.requireUserId(),
                PageRequest.of(Math.max(page, 0), 15)).map(this::toView);
    }

    private InspectionView toView(Inspection i) {
        List<InspectionView.MeasurementRow> rows = i.getMeasurements().stream()
                .map(m -> new InspectionView.MeasurementRow(m.getParameterName(), m.getExpectedMin(), m.getExpectedMax(),
                        m.getActualValue(), m.getUnit(), m.getResult(), m.getRemarks()))
                .toList();
        return new InspectionView(i.getId(), i.getBatch().getId(), i.getBatch().getBatchNumber(),
                i.getInspector().getFullName(), i.getInspectionType(), i.getStatus(), i.getFindings(), i.getInspectedAt(), rows);
    }

    private Batch loadBatch(Long batchId) {
        return batchRepository.findById(batchId).orElseThrow(() -> new ResourceNotFoundException("Batch", batchId));
    }

    private void requireInspector() {
        accessGuard.requireRole(RoleName.QUALITY_INSPECTOR, RoleName.ADMIN);
    }
}