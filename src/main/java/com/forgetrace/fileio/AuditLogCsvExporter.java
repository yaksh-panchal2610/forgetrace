package com.forgetrace.fileio;

import com.forgetrace.entity.AuditLog;
import com.forgetrace.repository.AuditLogRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * SAVES audit log entries to a CSV file on disk (folder: app.export-dir).
 * Used by the admin "Export audit log" button in Step 10.
 */
@Component
public class AuditLogCsvExporter extends AbstractCsvHandler<AuditLog> {

    private static final DateTimeFormatter FILE_STAMP =
            DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss").withZone(ZoneOffset.UTC);

    private final AuditLogRepository auditLogRepository;
    private final Path exportDirectory;

    public AuditLogCsvExporter(AuditLogRepository auditLogRepository,
                               @Value("${app.export-dir:exports}") String exportDirectory) {
        this.auditLogRepository = auditLogRepository;
        this.exportDirectory = Paths.get(exportDirectory).toAbsolutePath().normalize();
    }

    @Override
    protected List<String> headers() {
        return List.of("created_at_utc", "actor_email", "action", "entity_type", "entity_id", "details", "ip_address");
    }

    @Override
    protected AuditLog fromRow(Map<String, String> row) {
        throw new UnsupportedOperationException("Audit logs can only be exported, never imported.");
    }

    @Override
    protected List<String> toRow(AuditLog log) {
        return List.of(
                log.getCreatedAt() == null ? "" : log.getCreatedAt().toString(),
                log.getActorUser() == null ? "system" : log.getActorUser().getEmail(),
                log.getAction(),
                log.getEntityType(),
                log.getEntityId() == null ? "" : log.getEntityId().toString(),
                log.getDetails() == null ? "" : log.getDetails(),
                log.getIpAddress() == null ? "" : log.getIpAddress());
    }

    /** Writes all audit entries between from and to into a new CSV file and returns its path. */
    @Transactional(readOnly = true)
    public Path exportToFile(Instant from, Instant to) throws IOException {
        List<AuditLog> entries = auditLogRepository.findByCreatedAtBetweenOrderByCreatedAtAsc(from, to);
        Path file = exportDirectory.resolve("audit-log-" + FILE_STAMP.format(Instant.now()) + ".csv");
        return writeToFile(file, entries);
    }
}