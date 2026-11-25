package com.forgetrace.repository;

import com.forgetrace.entity.Organization;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.VerificationStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrganizationRepository extends JpaRepository<Organization, Long> {

    List<Organization> findByOrganizationTypeAndVerificationStatus(OrganizationType type, VerificationStatus status);

    long countByOrganizationTypeAndVerificationStatus(OrganizationType type, VerificationStatus status);

    Page<Organization> findByVerificationStatusOrderByCreatedAtAsc(VerificationStatus status, Pageable pageable);

    Page<Organization> findAllByOrderByCreatedAtDesc(Pageable pageable);
}