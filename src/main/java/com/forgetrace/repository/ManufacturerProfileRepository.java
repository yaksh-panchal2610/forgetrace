package com.forgetrace.repository;

import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.enums.VerificationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ManufacturerProfileRepository extends JpaRepository<ManufacturerProfile, Long> {

    /** Verified manufacturers that support BOTH the process and the material of an RFQ. */
    @Query("""
            select distinct mp from ManufacturerProfile mp
              join fetch mp.organization o
              join mp.processes p
              join mp.materials m
            where o.verificationStatus = :status
              and p.id = :processId
              and m.id = :materialId
            """)
    List<ManufacturerProfile> findMatching(@Param("processId") Long processId,
                                           @Param("materialId") Long materialId,
                                           @Param("status") VerificationStatus status);

    /** Public directory: all manufacturers with the given verification status. */
    @Query("""
            select mp from ManufacturerProfile mp
              join fetch mp.organization o
            where o.verificationStatus = :status
            order by o.displayName
            """)
    List<ManufacturerProfile> findDirectory(@Param("status") VerificationStatus status);
}