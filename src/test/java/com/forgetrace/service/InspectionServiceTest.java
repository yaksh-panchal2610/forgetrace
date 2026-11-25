package com.forgetrace.service;

import com.forgetrace.dto.request.InspectionRequest;
import com.forgetrace.dto.request.MeasurementRequest;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.Inspection;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.InspectionType;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.UnauthorizedOperationException;
import com.forgetrace.mapper.RfqMapper;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.InspectionRepository;
import com.forgetrace.repository.RfqAttachmentRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.support.TestData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.math.BigDecimal;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class InspectionServiceTest {

    @Mock InspectionRepository inspectionRepository;
    @Mock BatchRepository batchRepository;
    @Mock RfqAttachmentRepository attachmentRepository;
    @Mock UserRepository userRepository;
    @Mock BatchService batchService;
    @Mock PassportService passportService;
    @Mock NotificationService notificationService;
    @Mock RfqMapper rfqMapper;
    @Mock CurrentUserService currentUserService;
    @Mock AccessGuard accessGuard;
    @Mock AuditService auditService;

    @InjectMocks InspectionService service;

    private Batch batch;

    @BeforeEach
    void setUp() {
        batch = TestData.batch(3L, BatchStatus.AWAITING_INSPECTION, TestData.order(1L, OrderStatus.QUALITY_CHECK), "50");
        when(batchRepository.findById(3L)).thenReturn(Optional.of(batch));
        when(currentUserService.requireUserId()).thenReturn(8L);
        when(userRepository.getReferenceById(8L)).thenReturn(TestData.user(8L, "Quality Inspector"));
        when(inspectionRepository.save(any(Inspection.class))).thenAnswer(inv -> inv.getArgument(0));
    }

    private InspectionRequest request(InspectionStatus decision, String... actualValues) {
        InspectionRequest r = new InspectionRequest();
        r.setDecision(decision);
        r.setInspectionType(InspectionType.FINAL);
        for (String actual : actualValues) {
            MeasurementRequest m = new MeasurementRequest();
            m.setParameterName("Bore diameter");
            m.setExpectedMin(new BigDecimal("10.00"));
            m.setExpectedMax(new BigDecimal("10.50"));
            m.setActualValue(new BigDecimal(actual));
            m.setUnit("mm");
            r.getMeasurements().add(m);
        }
        return r;
    }

    @Test
    @DisplayName("FT-029: one out-of-tolerance measurement blocks approval")
    void failedMeasurementBlocksApproval() {
        assertThatThrownBy(() -> service.submit(3L, request(InspectionStatus.PASSED, "10.20", "10.80")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("1 measurement");
        assertThat(batch.getStatus()).isEqualTo(BatchStatus.AWAITING_INSPECTION);
        verify(passportService, never()).createForBatch(any());
    }

    @Test
    @DisplayName("FT-030: approval with all values in tolerance approves the batch and creates a passport")
    void approvalCreatesPassport() {
        Inspection inspection = service.submit(3L, request(InspectionStatus.PASSED, "10.20", "10.30"));

        assertThat(inspection.getStatus()).isEqualTo(InspectionStatus.PASSED);
        assertThat(inspection.getMeasurements()).hasSize(2).allMatch(m -> m.isPass());
        assertThat(batch.getStatus()).isEqualTo(BatchStatus.APPROVED);
        verify(passportService).createForBatch(batch);
        verify(notificationService).notifyOrganization(eq(TestData.BUYER_ORG), anyString(), anyString(), anyString());
    }

    @Test
    void rejectionMarksBatchRejectedWithoutPassport() {
        service.submit(3L, request(InspectionStatus.FAILED, "10.80"));

        assertThat(batch.getStatus()).isEqualTo(BatchStatus.REJECTED);
        verify(passportService, never()).createForBatch(any());
    }

    @Test
    void approvalNeedsAtLeastOneMeasurement() {
        assertThatThrownBy(() -> service.submit(3L, request(InspectionStatus.PASSED)))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("at least one");
    }

    @Test
    void maxBelowMinIsRejected() {
        InspectionRequest r = request(InspectionStatus.ON_HOLD, "10.2");
        r.getMeasurements().get(0).setExpectedMax(new BigDecimal("9.00"));

        assertThatThrownBy(() -> service.submit(3L, r))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("max");
    }

    @Test
    void batchNotWaitingForInspectionIsRejected() {
        batch.setStatus(BatchStatus.IN_PROGRESS);

        assertThatThrownBy(() -> service.submit(3L, request(InspectionStatus.PASSED, "10.2")))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("not waiting");
    }

    @Test
    @DisplayName("FT-028: a non-inspector cannot record an inspection")
    void onlyInspectorsMayInspect() {
        doThrow(new UnauthorizedOperationException("Your role is not allowed to do this."))
                .when(accessGuard).requireRole(RoleName.QUALITY_INSPECTOR, RoleName.ADMIN);

        assertThatThrownBy(() -> service.submit(3L, request(InspectionStatus.PASSED, "10.2")))
                .isInstanceOf(UnauthorizedOperationException.class);
        verify(inspectionRepository, never()).save(any());
    }
}