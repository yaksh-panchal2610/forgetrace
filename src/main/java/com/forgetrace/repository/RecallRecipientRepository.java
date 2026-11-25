package com.forgetrace.repository;

import com.forgetrace.entity.RecallRecipient;
import com.forgetrace.enums.AcknowledgementStatus;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RecallRecipientRepository extends JpaRepository<RecallRecipient, Long> {

    @EntityGraph(attributePaths = "organization")
    List<RecallRecipient> findByRecall_Id(Long recallId);

    @EntityGraph(attributePaths = {"recall", "recall.batch"})
    List<RecallRecipient> findByOrganization_IdAndAcknowledgementStatus(Long organizationId, AcknowledgementStatus status);
}