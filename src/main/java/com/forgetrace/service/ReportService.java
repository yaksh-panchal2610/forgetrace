package com.forgetrace.service;

import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.fileio.AuditLogCsvExporter;
import com.forgetrace.report.ReportFormat;
import com.forgetrace.report.ReportJob;
import com.forgetrace.report.ReportTaskRunner;
import com.forgetrace.report.ReportType;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Pattern;
import java.util.stream.Stream;

@Service
public class ReportService {

    private static final Pattern SAFE_NAME = Pattern.compile("^[A-Za-z0-9._-]{1,120}$");
    private static final int MAX_DAYS = 366;
    private static final int MAX_JOBS = 50;

    private final ReportTaskRunner runner;
    private final AuditLogCsvExporter auditLogCsvExporter;
    private final AccessGuard accessGuard;
    private final CurrentUserService currentUserService;
    private final AuditService auditService;
    private final Path exportDirectory;
    private final ZoneId zone;
    private final Map<String, ReportJob> jobs = new ConcurrentHashMap<>();

    public ReportService(ReportTaskRunner runner, AuditLogCsvExporter auditLogCsvExporter, AccessGuard accessGuard,
                         CurrentUserService currentUserService, AuditService auditService,
                         @Value("${app.export-dir:exports}") String exportDirectory,
                         @Value("${app.display-zone:Asia/Kolkata}") String displayZone) {
        this.runner = runner;
        this.auditLogCsvExporter = auditLogCsvExporter;
        this.accessGuard = accessGuard;
        this.currentUserService = currentUserService;
        this.auditService = auditService;
        this.exportDirectory = Paths.get(exportDirectory).toAbsolutePath().normalize();
        this.zone = ZoneId.of(displayZone);
    }

    public record FileRow(String name, long sizeKb, Instant modifiedAt) {
    }

    public ReportJob request(ReportType type, ReportFormat format, LocalDate from, LocalDate to) {
        requireAdmin();
        validateRange(from, to);
        ReportJob job = new ReportJob(type, format, from, to, currentUserService.requirePrincipal().getUsername());
        jobs.put(job.getId(), job);
        trimJobs();
        runner.run(job);
        auditService.record(currentUserService.requireUserId(), "REPORT_REQUESTED", "Report", null,
                type + " " + format + " " + from + " to " + to);
        return job;
    }

    public List<ReportJob> recentJobs() {
        requireAdmin();
        return jobs.values().stream()
                .sorted(Comparator.comparing(ReportJob::getCreatedAt).reversed())
                .limit(20)
                .toList();
    }

    public String exportAuditLog(LocalDate from, LocalDate to) throws IOException {
        requireAdmin();
        validateRange(from, to);
        Path file = auditLogCsvExporter.exportToFile(from.atStartOfDay(zone).toInstant(),
                to.plusDays(1).atStartOfDay(zone).toInstant());
        auditService.record(currentUserService.requireUserId(), "AUDIT_LOG_EXPORTED", "AuditLog", null,
                file.getFileName().toString());
        return file.getFileName().toString();
    }

    public List<FileRow> files() {
        requireAdmin();
        if (!Files.isDirectory(exportDirectory)) {
            return List.of();
        }
        try (Stream<Path> stream = Files.list(exportDirectory)) {
            return stream.filter(Files::isRegularFile)
                    .map(p -> {
                        try {
                            return new FileRow(p.getFileName().toString(), Math.max(1, Files.size(p) / 1024),
                                    Files.getLastModifiedTime(p).toInstant());
                        } catch (IOException ex) {
                            return null;
                        }
                    })
                    .filter(r -> r != null)
                    .sorted(Comparator.comparing(FileRow::modifiedAt).reversed())
                    .limit(50)
                    .toList();
        } catch (IOException ex) {
            return List.of();
        }
    }

    public Path resolveDownload(String name) {
        requireAdmin();
        if (name == null || !SAFE_NAME.matcher(name).matches()) {
            throw new ResourceNotFoundException("File not found.");
        }
        Path file = exportDirectory.resolve(name).normalize();
        if (!file.startsWith(exportDirectory) || !Files.isRegularFile(file)) {
            throw new ResourceNotFoundException("File not found.");
        }
        return file;
    }

    private void validateRange(LocalDate from, LocalDate to) {
        if (from == null || to == null) {
            throw new BusinessRuleException("Choose both dates.");
        }
        if (to.isBefore(from)) {
            throw new BusinessRuleException("'To' date must be on or after the 'From' date.");
        }
        if (ChronoUnit.DAYS.between(from, to) > MAX_DAYS) {
            throw new BusinessRuleException("A report can cover at most one year.");
        }
    }

    private void trimJobs() {
        if (jobs.size() <= MAX_JOBS) {
            return;
        }
        jobs.values().stream()
                .filter(ReportJob::isFinished)
                .sorted(Comparator.comparing(ReportJob::getCreatedAt))
                .limit(jobs.size() - MAX_JOBS)
                .forEach(j -> jobs.remove(j.getId()));
    }

    private void requireAdmin() {
        accessGuard.requireRole(RoleName.ADMIN);
    }
}