package com.forgetrace.service;

import com.forgetrace.concurrency.ManufacturerNotifier;
import com.forgetrace.dto.request.RfqCreateRequest;
import com.forgetrace.dto.response.RfqDetailView;
import com.forgetrace.dto.response.RfqSummary;
import com.forgetrace.entity.FileObject;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.Quotation;
import com.forgetrace.entity.Rfq;
import com.forgetrace.entity.RfqAttachment;
import com.forgetrace.enums.QuotationStatus;
import com.forgetrace.enums.RfqStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.RfqMapper;
import com.forgetrace.repository.ManufacturingProcessRepository;
import com.forgetrace.repository.MaterialRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.QuotationRepository;
import com.forgetrace.repository.RfqAttachmentRepository;
import com.forgetrace.repository.RfqRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.util.ReferenceNumberGenerator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * RFQ workflow:
 * Buyer validates and submits RFQ -> persist RFQ (+ drawings) -> AFTER COMMIT notify matching
 * verified manufacturers in parallel (ManufacturerNotifier).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RfqService {

    private static final int MAX_ATTACHMENTS = 5;
    private static final int PAGE_SIZE = 10;
    private static final Duration MIN_DEADLINE_LEAD = Duration.ofHours(1);

    private final RfqRepository rfqRepository;
    private final RfqAttachmentRepository attachmentRepository;
    private final QuotationRepository quotationRepository;
    private final ManufacturingProcessRepository processRepository;
    private final MaterialRepository materialRepository;
    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final FileService fileService;
    private final ManufacturerMatchingService matchingService;
    private final ManufacturerNotifier manufacturerNotifier;
    private final NotificationService notificationService;
    private final ReferenceNumberGenerator referenceNumbers;
    private final RfqMapper mapper;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    // ================= Buyer =================

    /** Empty form with sensible defaults and the company address pre-filled. */
    @Transactional(readOnly = true)
    public RfqCreateRequest newForm() {
        Organization org = organization(requireBuyerOrganization());
        RfqCreateRequest form = new RfqCreateRequest();
        form.setDeliveryAddress(Stream.of(org.getAddressLine1(), org.getAddressLine2(), org.getCity(),
                        org.getState(), org.getPostalCode())
                .filter(Objects::nonNull)
                .filter(s -> !s.isBlank())
                .collect(Collectors.joining(", ")));
        LocalDate today = LocalDate.now(zone());
        form.setQuoteDeadline(today.plusDays(7).atTime(LocalTime.of(17, 0)));
        form.setDeliveryDate(today.plusDays(30));
        return form;
    }

    @Transactional(readOnly = true)
    public List<ManufacturingProcess> activeProcesses() {
        return processRepository.findByActiveTrueOrderByProcessNameAsc();
    }

    @Transactional(readOnly = true)
    public List<Material> activeMaterials() {
        return materialRepository.findByActiveTrueOrderByMaterialNameAsc();
    }

    @Transactional
    public Rfq create(RfqCreateRequest form) {
        Long orgId = requireBuyerOrganization();
        Long userId = currentUserService.requireUserId();

        ManufacturingProcess process = processRepository.findById(form.getProcessId())
                .filter(ManufacturingProcess::isActive)
                .orElseThrow(() -> new BusinessRuleException("Choose a valid process."));
        Material material = materialRepository.findById(form.getMaterialId())
                .filter(Material::isActive)
                .orElseThrow(() -> new BusinessRuleException("Choose a valid material."));

        // Timeline rules (FT-013): deadline in the future, delivery after the deadline
        Instant now = Instant.now();
        Instant deadline = form.getQuoteDeadline().atZone(zone()).toInstant();
        if (deadline.isBefore(now.plus(MIN_DEADLINE_LEAD))) {
            throw new BusinessRuleException("The quote deadline must be at least one hour from now.");
        }
        LocalDate deadlineDay = deadline.atZone(zone()).toLocalDate();
        if (!form.getDeliveryDate().isAfter(deadlineDay)) {
            throw new BusinessRuleException("The delivery date must be after the quote deadline.");
        }

        // Validate ALL files before saving anything
        List<MultipartFile> files = form.getAttachments() == null ? List.of()
                : form.getAttachments().stream().filter(f -> f != null && !f.isEmpty()).toList();
        if (files.size() > MAX_ATTACHMENTS) {
            throw new BusinessRuleException("You can attach at most " + MAX_ATTACHMENTS + " files.");
        }
        files.forEach(fileService::validate);

        Rfq rfq = new Rfq();
        rfq.setRfqNumber(referenceNumbers.next("RFQ"));
        rfq.setBuyerOrganization(organizationRepository.getReferenceById(orgId));
        rfq.setCreatedBy(userRepository.getReferenceById(userId));
        rfq.setTitle(form.getTitle().trim());
        rfq.setDescription(blankToNull(form.getDescription()));
        rfq.setProcess(process);
        rfq.setMaterial(material);
        rfq.setQuantity(form.getQuantity());
        rfq.setQuantityUnit(form.getQuantityUnit().trim());
        rfq.setSpecifications(mapper.specsToJson(form.getSpecs()));
        rfq.setToleranceNotes(blankToNull(form.getToleranceNotes()));
        rfq.setDeliveryDate(form.getDeliveryDate());
        rfq.setDeliveryAddress(form.getDeliveryAddress().trim());
        rfq.setQuoteDeadline(deadline);
        rfq.setStatus(RfqStatus.OPEN);
        rfqRepository.save(rfq);

        for (MultipartFile file : files) {
            FileObject stored = fileService.upload(file, "rfq-attachments");
            RfqAttachment attachment = new RfqAttachment();
            attachment.setRfq(rfq);
            attachment.setFile(stored);
            attachment.setUploadedBy(userRepository.getReferenceById(userId));
            attachmentRepository.save(attachment);
        }

        auditService.record(userId, "RFQ_CREATED", "Rfq", rfq.getId(), rfq.getRfqNumber());
        // Runs on background threads only after this transaction commits
        manufacturerNotifier.notifyMatchingAfterCommit(rfq.getId());
        log.info("RFQ {} created by organization {} with {} attachment(s)", rfq.getRfqNumber(), orgId, files.size());
        return rfq;
    }

    @Transactional(readOnly = true)
    public Page<RfqSummary> listMine(int page) {
        Long orgId = requireBuyerOrganization();
        return rfqRepository.findByBuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(Math.max(page, 0), PAGE_SIZE))
                .map(rfq -> mapper.toSummary(rfq,
                        quotationRepository.countByRfq_IdAndStatus(rfq.getId(), QuotationStatus.SUBMITTED), false));
    }

    @Transactional(readOnly = true)
    public RfqDetailView detailForBuyer(Long rfqId) {
        Rfq rfq = load(rfqId);
        accessGuard.requireMembership(rfq.getBuyerOrganization().getId());
        return mapper.toDetail(rfq, attachmentRepository.findByRfq_Id(rfqId), Instant.now());
    }

    @Transactional
    public void cancel(Long rfqId) {
        Rfq rfq = load(rfqId);
        accessGuard.requireMembership(rfq.getBuyerOrganization().getId());
        if (rfq.getStatus() != RfqStatus.OPEN && rfq.getStatus() != RfqStatus.CLOSED) {
            throw new BusinessRuleException("Only open RFQs can be cancelled.");
        }
        rfq.setStatus(RfqStatus.CANCELLED);

        for (Quotation quotation : quotationRepository.findByRfq_IdAndStatus(rfqId, QuotationStatus.SUBMITTED)) {
            quotation.setStatus(QuotationStatus.REJECTED);
            notificationService.notifyOrganization(quotation.getManufacturerOrganization().getId(),
                    "RFQ cancelled: " + rfq.getTitle(),
                    "The buyer cancelled " + rfq.getRfqNumber() + ". Your quotation " + quotation.getQuotationNumber()
                            + " is closed.",
                    "/manufacturer/quotations");
        }
        auditService.record(currentUserService.requireUserId(), "RFQ_CANCELLED", "Rfq", rfqId, rfq.getRfqNumber());
    }

    // ================= Manufacturer =================

    @Transactional(readOnly = true)
    public boolean currentManufacturerVerified() {
        return organization(requireManufacturerOrganization()).isVerified();
    }

    /** Open RFQs that match this manufacturer's capabilities. Unverified manufacturers see none (FT-017). */
    @Transactional(readOnly = true)
    public List<RfqSummary> inbox() {
        Long orgId = requireManufacturerOrganization();
        if (!organization(orgId).isVerified()) {
            return List.of();
        }
        return rfqRepository.findOpenMatchingForManufacturer(orgId, RfqStatus.OPEN, Instant.now()).stream()
                .map(rfq -> mapper.toSummary(rfq, 0,
                        quotationRepository.existsByRfq_IdAndManufacturerOrganization_Id(rfq.getId(), orgId)))
                .toList();
    }

    @Transactional(readOnly = true)
    public RfqDetailView detailForManufacturer(Long rfqId) {
        Long orgId = requireManufacturerOrganization();
        Rfq rfq = load(rfqId);
        boolean eligible = matchingService.isEligible(orgId, rfq.getProcess().getId(), rfq.getMaterial().getId());
        boolean alreadyQuoted = quotationRepository.existsByRfq_IdAndManufacturerOrganization_Id(rfqId, orgId);
        if (!eligible && !alreadyQuoted) {
            // Same answer as "does not exist" - no information leak
            throw new ResourceNotFoundException("RFQ", rfqId);
        }
        return mapper.toDetail(rfq, attachmentRepository.findByRfq_Id(rfqId), Instant.now());
    }

    // ================= helpers =================

    private Rfq load(Long rfqId) {
        return rfqRepository.findWithDetailsById(rfqId)
                .orElseThrow(() -> new ResourceNotFoundException("RFQ", rfqId));
    }

    private Organization organization(Long orgId) {
        return organizationRepository.findById(orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", orgId));
    }

    private Long requireBuyerOrganization() {
        accessGuard.requireRole(RoleName.BUYER);
        return currentUserService.requireOrganizationId();
    }

    private Long requireManufacturerOrganization() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        return currentUserService.requireOrganizationId();
    }

    private ZoneId zone() {
        return ZoneId.of(displayZone);
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}