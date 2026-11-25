package com.forgetrace.repository;

import com.forgetrace.entity.ContactRequest;
import com.forgetrace.enums.ContactStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactRequestRepository extends JpaRepository<ContactRequest, Long> {

    Page<ContactRequest> findByStatusOrderByCreatedAtDesc(ContactStatus status, Pageable pageable);

    long countByStatus(ContactStatus status);
}