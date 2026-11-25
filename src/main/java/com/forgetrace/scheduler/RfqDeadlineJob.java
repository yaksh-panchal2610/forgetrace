package com.forgetrace.scheduler;

import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.QuotationStatus;
import com.forgetrace.enums.RfqStatus;
import com.forgetrace.repository.QuotationRepository;
import com.forgetrace.repository.RfqRepository;
import com.forgetrace.service.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

/**
 * When an RFQ's quote deadline passes:
 * - with quotations    -> CLOSED (buyer can still compare and accept valid quotes)
 * - without quotations -> EXPIRED
 * The buyer is notified either way.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class RfqDeadlineJob {

    private final RfqRepository rfqRepository;
    private final QuotationRepository quotationRepository;
    private final NotificationService notificationService;

    @Scheduled(fixedDelayString = "${app.jobs.check-interval-ms:300000}",
               initialDelayString = "${app.jobs.initial-delay-ms:60000}")
    @Transactional
    public void closeRfqsPastDeadline() {
        List<Rfq> due = rfqRepository.findByStatusAndQuoteDeadlineBefore(RfqStatus.OPEN, Instant.now());
        for (Rfq rfq : due) {
            long quotations = quotationRepository.countByRfq_IdAndStatus(rfq.getId(), QuotationStatus.SUBMITTED);
            if (quotations > 0) {
                rfq.setStatus(RfqStatus.CLOSED);
                notificationService.notifyOrganization(rfq.getBuyerOrganization().getId(),
                        "Quote deadline reached: " + rfq.getTitle(),
                        quotations + " quotation(s) are ready to compare.",
                        "/buyer/rfqs/" + rfq.getId());
            } else {
                rfq.setStatus(RfqStatus.EXPIRED);
                notificationService.notifyOrganization(rfq.getBuyerOrganization().getId(),
                        "No quotations received: " + rfq.getTitle(),
                        "The quote deadline passed without any quotations. You can post a new RFQ with a later deadline.",
                        "/buyer/rfqs/" + rfq.getId());
            }
        }
        if (!due.isEmpty()) {
            log.info("RfqDeadlineJob: {} RFQ(s) closed after their deadline", due.size());
        }
    }
}