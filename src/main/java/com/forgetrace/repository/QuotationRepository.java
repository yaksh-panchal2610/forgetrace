package com.forgetrace.repository;

import com.forgetrace.entity.Quotation;
import com.forgetrace.enums.QuotationStatus;
import jakarta.persistence.LockModeType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

public interface QuotationRepository extends JpaRepository<Quotation, Long> {

    /** Buyer comparison screen: active quotes for an RFQ, cheapest first. */
    @EntityGraph(attributePaths = "manufacturerOrganization")
    List<Quotation> findByRfq_IdAndStatusOrderByTotalAmountAsc(Long rfqId, QuotationStatus status);

    @EntityGraph(attributePaths = {"manufacturerOrganization", "rfq"})
    List<Quotation> findByRfq_IdOrderByCreatedAtDesc(Long rfqId);

    @EntityGraph(attributePaths = "rfq")
    Page<Quotation> findByManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId, Pageable pageable);

    /** All quotations received on any of a buyer's RFQs. */
    @EntityGraph(attributePaths = {"rfq", "manufacturerOrganization"})
    Page<Quotation> findByRfq_BuyerOrganization_IdOrderByCreatedAtDesc(Long buyerOrganizationId, Pageable pageable);

    /** Latest version this manufacturer submitted for this RFQ. */
    Optional<Quotation> findTopByRfq_IdAndManufacturerOrganization_IdOrderByVersionNumberDesc(Long rfqId, Long manufacturerId);

    List<Quotation> findByRfq_IdAndStatus(Long rfqId, QuotationStatus status);

    long countByRfq_IdAndStatus(Long rfqId, QuotationStatus status);

    boolean existsByRfq_IdAndManufacturerOrganization_Id(Long rfqId, Long manufacturerId);

    List<Quotation> findByStatusAndValidUntilBefore(QuotationStatus status, Instant time);

    /**
     * Locks the quotation row until the transaction ends.
     * Two buyers clicking "Accept" at the same time cannot both succeed (test FT-020).
     */
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select q from Quotation q where q.id = :id")
    Optional<Quotation> findByIdForUpdate(@Param("id") Long id);
}