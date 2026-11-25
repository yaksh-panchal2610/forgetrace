package com.forgetrace.service;

import com.forgetrace.config.DisplayFormatter;
import com.forgetrace.dto.request.QuotationCreateRequest;
import com.forgetrace.dto.response.QuotationComparisonRow;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.Quotation;
import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.QuotationStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.exception.UnauthorizedOperationException;
import com.forgetrace.mapper.QuotationMapper;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.QuotationRepository;
import com.forgetrace.repository.ReviewRepository;
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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Quotations: submit (with versioning), withdraw, compare, reject.
 * Accepting a quotation creates an order - that is OrderService (Step 7).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class QuotationService {

    private static final int PAGE_SIZE = 10;
    private static final int MAX_VALIDITY_DAYS = 180;

    private final QuotationRepository quotationRepository;
    private final RfqRepository rfqRepository;
    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final ReviewRepository reviewRepository;
    private final ManufacturerMatchingService matchingService;
    private final ReferenceNumberGenerator referenceNumbers;
    private final QuotationMapper mapper;
    private final NotificationService notificationService;
    private final DisplayFormatter formatter;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    /** Price breakdown. Static and pure, so it is easy to unit test. */
    public record Price(BigDecimal subtotal, BigDecimal tax, BigDecimal total) {
    }

    /** subtotal = unit price x quantity + setup fee; tax = subtotal x rate%; all rounded to paise. */
    public static Price calculate(BigDecimal unitPrice, BigDecimal quantity, BigDecimal setupFee, BigDecimal taxRatePercent) {
        BigDecimal subtotal = unitPrice.multiply(quantity).add(setupFee).setScale(2, RoundingMode.HALF_UP);
        BigDecimal tax = subtotal.multiply(taxRatePercent)
                .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        return new Price(subtotal, tax, subtotal.add(tax));
    }

    // ================= Manufacturer =================

    @Transactional(readOnly = true)
    public QuotationCreateRequest newForm(Long rfqId) {
        Long orgId = requireManufacturerOrganization();
        eligibleRfq(rfqId, orgId);
        return quotationRepository.findTopByRfq_IdAndManufacturerOrganization_IdOrderByVersionNumberDesc(rfqId, orgId)
                .map(previous -> mapper.toRevisionForm(previous, zone()))
                .orElseGet(() -> {
                    QuotationCreateRequest form = new QuotationCreateRequest();
                    form.setValidUntil(LocalDate.now(zone()).plusDays(14));
                    return form;
                });
    }

    @Transactional
    public QuotationComparisonRow submit(Long rfqId, QuotationCreateRequest form) {
        Long orgId = requireManufacturerOrganization();
        Organization manufacturer = organizationRepository.findById(orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", orgId));
        if (!manufacturer.isVerified()) {
            throw new UnauthorizedOperationException("Your company must be verified by an admin before it can quote.");
        }

        Rfq rfq = eligibleRfq(rfqId, orgId);
        Instant now = Instant.now();
        if (!rfq.isOpenFor(now)) {
            throw new BusinessRuleException("This RFQ is no longer accepting quotations.");
        }

        LocalDate today = LocalDate.now(zone());
        if (form.getValidUntil().isBefore(today)) {
            throw new BusinessRuleException("'Valid until' must be today or later.");
        }
        if (form.getValidUntil().isAfter(today.plusDays(MAX_VALIDITY_DAYS))) {
            throw new BusinessRuleException("A quotation can be valid for at most " + MAX_VALIDITY_DAYS + " days.");
        }
        Instant validUntil = form.getValidUntil().plusDays(1).atStartOfDay(zone()).toInstant().minusSeconds(1);

        // Versioning: a new offer replaces the previous SUBMITTED one
        Optional<Quotation> previous = quotationRepository
                .findTopByRfq_IdAndManufacturerOrganization_IdOrderByVersionNumberDesc(rfqId, orgId);
        if (previous.isPresent() && previous.get().getStatus() == QuotationStatus.ACCEPTED) {
            throw new BusinessRuleException("Your quotation for this RFQ has already been accepted.");
        }
        previous.filter(q -> q.getStatus() == QuotationStatus.SUBMITTED)
                .ifPresent(q -> q.setStatus(QuotationStatus.SUPERSEDED));
        int version = previous.map(q -> q.getVersionNumber() + 1).orElse(1);

        Price price = calculate(form.getUnitPrice(), rfq.getQuantity(), form.getSetupFee(), form.getTaxRatePercent());

        Quotation quotation = new Quotation();
        quotation.setQuotationNumber(referenceNumbers.next("QTN"));
        quotation.setRfq(rfq);
        quotation.setManufacturerOrganization(manufacturer);
        quotation.setSubmittedBy(userRepository.getReferenceById(currentUserService.requireUserId()));
        quotation.setVersionNumber(version);
        quotation.setUnitPrice(form.getUnitPrice());
        quotation.setSetupFee(form.getSetupFee());
        quotation.setTaxAmount(price.tax());
        quotation.setTotalAmount(price.total());
        quotation.setLeadTimeDays(form.getLeadTimeDays());
        quotation.setValidUntil(validUntil);
        quotation.setTerms(form.getTerms() == null || form.getTerms().isBlank() ? null : form.getTerms().trim());
        quotationRepository.save(quotation);

        notificationService.notifyOrganization(rfq.getBuyerOrganization().getId(),
                (version > 1 ? "Revised quotation for " : "New quotation for ") + rfq.getTitle(),
                manufacturer.getDisplayName() + " quoted " + formatter.money(price.total(), quotation.getCurrency())
                        + " with a lead time of " + form.getLeadTimeDays() + " day(s).",
                "/buyer/quotations/" + quotation.getId());

        auditService.record(currentUserService.requireUserId(), "QUOTATION_SUBMITTED", "Quotation",
                quotation.getId(), quotation.getQuotationNumber() + " v" + version);
        return mapper.toRow(quotation, now, false, false, null);
    }

    @Transactional
    public void withdraw(Long quotationId) {
        Long orgId = requireManufacturerOrganization();
        Quotation quotation = ownQuotation(quotationId, orgId);
        if (quotation.getStatus() != QuotationStatus.SUBMITTED) {
            throw new BusinessRuleException("Only submitted quotations can be withdrawn.");
        }
        quotation.setStatus(QuotationStatus.WITHDRAWN);
        notificationService.notifyOrganization(quotation.getRfq().getBuyerOrganization().getId(),
                "Quotation withdrawn",
                quotation.getManufacturerOrganization().getDisplayName() + " withdrew quotation "
                        + quotation.getQuotationNumber() + " for " + quotation.getRfq().getTitle() + ".",
                "/buyer/rfqs/" + quotation.getRfq().getId());
        auditService.record(currentUserService.requireUserId(), "QUOTATION_WITHDRAWN", "Quotation", quotationId, null);
    }

    @Transactional(readOnly = true)
    public Page<QuotationComparisonRow> myQuotations(int page) {
        Long orgId = requireManufacturerOrganization();
        Instant now = Instant.now();
        return quotationRepository
                .findByManufacturerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(Math.max(page, 0), PAGE_SIZE))
                .map(q -> mapper.toRow(q, now, false, false, null));
    }

    /** This manufacturer's versions for one RFQ, newest first. */
    @Transactional(readOnly = true)
    public List<QuotationComparisonRow> myQuotationsForRfq(Long rfqId) {
        Long orgId = requireManufacturerOrganization();
        Instant now = Instant.now();
        return quotationRepository.findByRfq_IdOrderByCreatedAtDesc(rfqId).stream()
                .filter(q -> q.getManufacturerOrganization().getId().equals(orgId))
                .map(q -> mapper.toRow(q, now, false, false, null))
                .toList();
    }

    // ================= Buyer =================

    /**
     * Comparison table for one RFQ. Superseded versions are hidden.
     * Flags the cheapest and the fastest among quotes that can still be accepted.
     */
    @Transactional(readOnly = true)
    public List<QuotationComparisonRow> compareForRfq(Long rfqId) {
        Rfq rfq = rfqRepository.findById(rfqId).orElseThrow(() -> new ResourceNotFoundException("RFQ", rfqId));
        accessGuard.requireMembership(rfq.getBuyerOrganization().getId());

        Instant now = Instant.now();
        List<Quotation> quotations = quotationRepository.findByRfq_IdOrderByCreatedAtDesc(rfqId).stream()
                .filter(q -> q.getStatus() != QuotationStatus.SUPERSEDED)
                .toList();
        List<Quotation> acceptable = quotations.stream()
                .filter(q -> q.getStatus() == QuotationStatus.SUBMITTED && !q.isExpired(now))
                .toList();

        BigDecimal lowestTotal = acceptable.stream().map(Quotation::getTotalAmount).min(Comparator.naturalOrder()).orElse(null);
        Integer shortestLead = acceptable.stream().map(Quotation::getLeadTimeDays).min(Comparator.naturalOrder()).orElse(null);
        Map<Long, Double> ratings = new HashMap<>();

        return quotations.stream()
                .map(q -> {
                    boolean canAccept = acceptable.contains(q);
                    Long manufacturerId = q.getManufacturerOrganization().getId();
                    Double rating = ratings.computeIfAbsent(manufacturerId, reviewRepository::averageRating);
                    return mapper.toRow(q, now,
                            canAccept && q.getTotalAmount().compareTo(lowestTotal) == 0,
                            canAccept && q.getLeadTimeDays().equals(shortestLead),
                            rating);
                })
                .sorted(Comparator.comparing(QuotationComparisonRow::isAcceptable).reversed()
                        .thenComparing(QuotationComparisonRow::totalAmount))
                .toList();
    }

    @Transactional(readOnly = true)
    public Page<QuotationComparisonRow> buyerQuotations(int page) {
        Long orgId = requireBuyerOrganization();
        Instant now = Instant.now();
        return quotationRepository
                .findByRfq_BuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(Math.max(page, 0), PAGE_SIZE))
                .map(q -> mapper.toRow(q, now, false, false, null));
    }

    @Transactional(readOnly = true)
    public QuotationComparisonRow detailForBuyer(Long quotationId) {
        Quotation quotation = quotationRepository.findById(quotationId)
                .orElseThrow(() -> new ResourceNotFoundException("Quotation", quotationId));
        accessGuard.requireMembership(quotation.getRfq().getBuyerOrganization().getId());
        Double rating = reviewRepository.averageRating(quotation.getManufacturerOrganization().getId());
        return mapper.toRow(quotation, Instant.now(), false, false, rating);
    }

    @Transactional
    public void reject(Long quotationId) {
        Quotation quotation = quotationRepository.findById(quotationId)
                .orElseThrow(() -> new ResourceNotFoundException("Quotation", quotationId));
        accessGuard.requireMembership(quotation.getRfq().getBuyerOrganization().getId());
        if (quotation.getStatus() != QuotationStatus.SUBMITTED) {
            throw new BusinessRuleException("Only submitted quotations can be rejected.");
        }
        quotation.setStatus(QuotationStatus.REJECTED);
        notificationService.notifyOrganization(quotation.getManufacturerOrganization().getId(),
                "Quotation not selected",
                "The buyer declined quotation " + quotation.getQuotationNumber() + " for " + quotation.getRfq().getTitle() + ".",
                "/manufacturer/quotations");
        auditService.record(currentUserService.requireUserId(), "QUOTATION_REJECTED", "Quotation", quotationId, null);
    }

    // ================= helpers =================

    private Rfq eligibleRfq(Long rfqId, Long manufacturerOrgId) {
        Rfq rfq = rfqRepository.findWithDetailsById(rfqId)
                .orElseThrow(() -> new ResourceNotFoundException("RFQ", rfqId));
        if (!matchingService.isEligible(manufacturerOrgId, rfq.getProcess().getId(), rfq.getMaterial().getId())) {
            throw new ResourceNotFoundException("RFQ", rfqId);
        }
        return rfq;
    }

    private Quotation ownQuotation(Long quotationId, Long manufacturerOrgId) {
        return quotationRepository.findById(quotationId)
                .filter(q -> q.getManufacturerOrganization().getId().equals(manufacturerOrgId))
                .orElseThrow(() -> new ResourceNotFoundException("Quotation", quotationId));
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
}