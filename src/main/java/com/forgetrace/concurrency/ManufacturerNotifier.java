package com.forgetrace.concurrency;

import com.forgetrace.entity.Rfq;
import com.forgetrace.notification.NotificationMessage;
import com.forgetrace.repository.RfqRepository;
import com.forgetrace.service.ManufacturerMatchingService;
import com.forgetrace.service.NotificationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;

@Slf4j
@Component
public class ManufacturerNotifier {

    private final ExecutorService executor;
    private final ManufacturerMatchingService matchingService;
    private final RfqRepository rfqRepository;
    private final NotificationService notificationService;
    private final TransactionTemplate readOnlyTransaction;

    public ManufacturerNotifier(@Qualifier("notificationExecutor") ExecutorService executor,
                                ManufacturerMatchingService matchingService,
                                RfqRepository rfqRepository,
                                NotificationService notificationService,
                                PlatformTransactionManager transactionManager) {
        this.executor = executor;
        this.matchingService = matchingService;
        this.rfqRepository = rfqRepository;
        this.notificationService = notificationService;
        this.readOnlyTransaction = new TransactionTemplate(transactionManager);
        this.readOnlyTransaction.setReadOnly(true);
    }

    /** Call this inside the RFQ-creating transaction. The real work waits until commit. */
    public void notifyMatchingAfterCommit(Long rfqId) {
        if (TransactionSynchronizationManager.isSynchronizationActive()) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() {
                    notifyMatching(rfqId);
                }
            });
        } else {
            notifyMatching(rfqId);
        }
    }

    /**
     * Sends all notifications in parallel. Returns a future that completes with the number of
     * messages sent - the request thread does not wait for it, but unit tests can.
     */
    public CompletableFuture<Integer> notifyMatching(Long rfqId) {
        // 1. Read everything needed on the current thread, inside a short read-only transaction
        List<NotificationMessage> messages = readOnlyTransaction.execute(status -> buildMessages(rfqId));
        if (messages == null || messages.isEmpty()) {
            log.info("RFQ {}: no matching verified manufacturers to notify", rfqId);
            return CompletableFuture.completedFuture(0);
        }

        // 2. Fan out: one task per recipient, run on the bounded thread pool
        List<CompletableFuture<Void>> tasks = messages.stream()
                .map(message -> CompletableFuture.runAsync(() -> notificationService.send(message), executor))
                .toList();

        // 3. Completes when every task has finished (tasks never throw - channels catch their own errors)
        return CompletableFuture.allOf(tasks.toArray(CompletableFuture[]::new))
                .thenApply(done -> {
                    log.info("RFQ {}: notified {} user(s) in parallel", rfqId, messages.size());
                    return messages.size();
                });
    }

    private List<NotificationMessage> buildMessages(Long rfqId) {
        Rfq rfq = rfqRepository.findWithDetailsById(rfqId).orElse(null);
        if (rfq == null) {
            return List.of();
        }
        String title = "New RFQ: " + rfq.getTitle();
        String body = rfq.getRfqNumber() + " · " + rfq.getProcess().getProcessName()
                + " · " + rfq.getMaterial().getMaterialName()
                + " · " + rfq.getQuantity().stripTrailingZeros().toPlainString() + " " + rfq.getQuantityUnit()
                + ". Submit your quotation before the deadline.";
        String link = "/manufacturer/rfqs/" + rfqId;

        return matchingService.matchingManufacturerIds(rfq.getProcess().getId(), rfq.getMaterial().getId())
                .stream()
                .flatMap(orgId -> notificationService.messagesForOrganization(orgId, title, body, link).stream())
                .toList();
    }
}