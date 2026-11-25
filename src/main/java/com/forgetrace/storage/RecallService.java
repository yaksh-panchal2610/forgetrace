package com.forgetrace.storage;

import com.forgetrace.dto.request.RecallRequest;
import com.forgetrace.dto.response.BatchView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductPassport;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Recall;
import com.forgetrace.entity.RecallRecipient;
import com.forgetrace.enums.AcknowledgementStatus;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.RecallSeverity;
import com.forgetrace.enums.RecallStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.repository.RecallRecipientRepository;
import com.forgetrace.repository.RecallRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.service.AuditService;
import com.forgetrace.service.BatchService;
import com.forgetrace.service.NotificationService;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RecallService {

    private final RecallRepository recallRepository;
    private final RecallRecipientRepository recipientRepository;
    private final BatchRepository batchRepository;
    private final ProductPassportRepository passportRepository;
    private final UserRepository userRepository;
    private final BatchService batchService;
    private final NotificationService notificationService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    public record RecipientRow(String organizationName, Instant notifiedAt, AcknowledgementStatus status, Instant acknowledgedAt) {
    }

    public record RecallView(Long id, Long batchId, String batchNumber, String orderNumber, String manufacturerName,
                             String initiatedBy, String reason, RecallSeverity severity, RecallStatus status,
                             Instant createdAt, List<RecipientRow> recipients) {
        public long getPendingCount() {
            return recipients.stream().filter(r -> r.status() == AcknowledgementStatus.PENDING).count();
        }

        public boolean isOpen() {
            return status != RecallStatus.CLOSED;
        }
    }

    public record RecallNotice(Long recipientId, String batchNumber, RecallSeverity severity, String reason,
                               Instant createdAt, UUID passportToken) {
    }

    @Transactional(readOnly = true)
    public BatchView batchForRecall(Long batchId) {
        requireAdmin();
        Batch batch = loadBatch(batchId);
        if (!batch.getStatus().canTransitionTo(BatchStatus.RECALLED)) {
            throw new BusinessRuleException("Only approved or shipped batches can be recalled.");
        }
        return batchService.view(batch);
    }

    @Transactional
    public Recall initiate(RecallRequest form) {
        requireAdmin();
        Long adminId = currentUserService.requireUserId();
        Batch batch = loadBatch(form.getBatchId());
        if (!batch.getStatus().canTransitionTo(BatchStatus.RECALLED)) {
            throw new BusinessRuleException("Only approved or shipped batches can be recalled.");
        }
        ProductionOrder order = batch.getProductionOrder();

        Recall recall = new Recall();
        recall.setBatch(batch);
        recall.setInitiatedBy(userRepository.getReferenceById(adminId));
        recall.setReason(form.getReason().trim());
        recall.setSeverity(form.getSeverity());
        recall.setStatus(RecallStatus.INITIATED);
        batch.setStatus(BatchStatus.RECALLED);

        RecallRecipient recipient = new RecallRecipient();
        recipient.setOrganization(order.getBuyerOrganization());
        recipient.setNotifiedAt(Instant.now());
        recall.addRecipient(recipient);
        recallRepository.save(recall);

        String title = "RECALL (" + form.getSeverity().getLabel() + "): batch " + batch.getBatchNumber();
        notificationService.notifyOrganization(order.getBuyerOrganization().getId(), title,
                recall.getReason() + " Please stop using this batch and acknowledge the notice.", "/buyer/passports");
        notificationService.notifyOrganization(order.getManufacturerOrganization().getId(), title, recall.getReason(),
                "/manufacturer/batches?orderId=" + order.getId());
        recall.setStatus(RecallStatus.NOTIFIED);
        auditService.record(adminId, "RECALL_INITIATED", "Batch", batch.getId(), form.getSeverity() + ": " + recall.getReason());
        return recall;
    }

    @Transactional(readOnly = true)
    public Page<RecallView> list(int page) {
        requireAdmin();
        return recallRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(Math.max(page, 0), 20)).map(this::toView);
    }

    @Transactional(readOnly = true)
    public RecallView detail(Long id) {
        requireAdmin();
        return recallRepository.findById(id).map(this::toView).orElseThrow(() -> new ResourceNotFoundException("Recall", id));
    }

    @Transactional
    public void close(Long id) {
        requireAdmin();
        Recall recall = recallRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Recall", id));
        if (recall.getStatus() == RecallStatus.CLOSED) {
            throw new BusinessRuleException("This recall is already closed.");
        }
        recall.setStatus(RecallStatus.CLOSED);
        auditService.record(currentUserService.requireUserId(), "RECALL_CLOSED", "Recall", id, null);
    }

    @Transactional(readOnly = true)
    public List<RecallNotice> noticesForBuyer() {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        return recipientRepository.findByOrganization_IdAndAcknowledgementStatus(orgId, AcknowledgementStatus.PENDING).stream()
                .map(r -> {
                    Recall recall = r.getRecall();
                    UUID token = passportRepository.findByBatch_Id(recall.getBatch().getId())
                            .map(ProductPassport::getPublicToken).orElse(null);
                    return new RecallNotice(r.getId(), recall.getBatch().getBatchNumber(), recall.getSeverity(),
                            recall.getReason(), recall.getCreatedAt(), token);
                })
                .toList();
    }

    @Transactional
    public void acknowledge(Long recipientId) {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        RecallRecipient recipient = recipientRepository.findById(recipientId)
                .filter(r -> r.getOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Recall notice", recipientId));
        if (recipient.getAcknowledgementStatus() == AcknowledgementStatus.ACKNOWLEDGED) {
            return;
        }
        recipient.setAcknowledgementStatus(AcknowledgementStatus.ACKNOWLEDGED);
        recipient.setAcknowledgedAt(Instant.now());
        auditService.record(currentUserService.requireUserId(), "RECALL_ACKNOWLEDGED", "Recall",
                recipient.getRecall().getId(), null);
    }

    private RecallView toView(Recall r) {
        Batch b = r.getBatch();
        List<RecipientRow> recipients = r.getRecipients().stream()
                .map(x -> new RecipientRow(x.getOrganization().getDisplayName(), x.getNotifiedAt(),
                        x.getAcknowledgementStatus(), x.getAcknowledgedAt()))
                .toList();
        return new RecallView(r.getId(), b.getId(), b.getBatchNumber(), b.getProductionOrder().getOrderNumber(),
                b.getProductionOrder().getManufacturerOrganization().getDisplayName(), r.getInitiatedBy().getFullName(),
                r.getReason(), r.getSeverity(), r.getStatus(), r.getCreatedAt(), recipients);
    }

    private Batch loadBatch(Long batchId) {
        return batchRepository.findById(batchId).orElseThrow(() -> new ResourceNotFoundException("Batch", batchId));
    }

    private void requireAdmin() {
        accessGuard.requireRole(RoleName.ADMIN);
    }
}