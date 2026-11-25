package com.forgetrace.repository;

import com.forgetrace.entity.RfqAttachment;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RfqAttachmentRepository extends JpaRepository<RfqAttachment, Long> {

    @EntityGraph(attributePaths = "file")
    List<RfqAttachment> findByRfq_Id(Long rfqId);

    /** Which RFQ(s) a file is attached to - used to decide who may download it. */
    @EntityGraph(attributePaths = "rfq")
    List<RfqAttachment> findByFile_Id(Long fileId);
}