package com.forgetrace.scheduler;

import com.forgetrace.entity.Quotation;
import com.forgetrace.enums.QuotationStatus;
import com.forgetrace.repository.QuotationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

/** Marks submitted quotations whose "valid until" has passed as EXPIRED. */
@Slf4j
@Component
@RequiredArgsConstructor
public class QuotationExpiryJob {

    private final QuotationRepository quotationRepository;

    @Scheduled(fixedDelayString = "${app.jobs.check-interval-ms:300000}",
               initialDelayString = "${app.jobs.initial-delay-ms:60000}")
    @Transactional
    public void expireQuotations() {
        List<Quotation> due = quotationRepository.findByStatusAndValidUntilBefore(QuotationStatus.SUBMITTED, Instant.now());
        due.forEach(q -> q.setStatus(QuotationStatus.EXPIRED));
        if (!due.isEmpty()) {
            log.info("QuotationExpiryJob: {} quotation(s) expired", due.size());
        }
    }
}