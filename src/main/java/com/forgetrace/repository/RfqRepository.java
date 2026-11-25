package com.forgetrace.repository;

import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.RfqStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

public interface RfqRepository extends JpaRepository<Rfq, Long> {

    Optional<Rfq> findByRfqNumber(String rfqNumber);

    @EntityGraph(attributePaths = {"process", "material", "buyerOrganization", "createdBy"})
    Optional<Rfq> findWithDetailsById(Long id);

    @EntityGraph(attributePaths = {"process", "material"})
    Page<Rfq> findByBuyerOrganization_IdOrderByCreatedAtDesc(Long buyerOrganizationId, Pageable pageable);

    long countByBuyerOrganization_IdAndStatus(Long buyerOrganizationId, RfqStatus status);

    long countByStatus(RfqStatus status);

    /** Used by the scheduler to expire RFQs whose deadline has passed. */
    List<Rfq> findByStatusAndQuoteDeadlineBefore(RfqStatus status, Instant time);

    /** Manufacturer inbox: open RFQs whose process AND material this manufacturer supports. */
    @Query("""
            select r from Rfq r
              join fetch r.process
              join fetch r.material
              join fetch r.buyerOrganization
            where r.status = :status
              and r.quoteDeadline > :now
              and r.process.id in (
                  select p.id from ManufacturerProfile mp join mp.processes p
                  where mp.organizationId = :manufacturerId)
              and r.material.id in (
                  select m.id from ManufacturerProfile mp2 join mp2.materials m
                  where mp2.organizationId = :manufacturerId)
            order by r.quoteDeadline asc
            """)
    List<Rfq> findOpenMatchingForManufacturer(@Param("manufacturerId") Long manufacturerId,
                                              @Param("status") RfqStatus status,
                                              @Param("now") Instant now);
}