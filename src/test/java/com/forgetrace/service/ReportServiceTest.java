package com.forgetrace.service;

import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.fileio.AuditLogCsvExporter;
import com.forgetrace.report.ReportFormat;
import com.forgetrace.report.ReportJob;
import com.forgetrace.report.ReportTaskRunner;
import com.forgetrace.report.ReportType;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.security.ForgeTraceUserPrincipal;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class ReportServiceTest {

    @TempDir
    Path exportDir;

    private ReportTaskRunner runner;
    private ReportService service;

    @BeforeEach
    void setUp() {
        runner = mock(ReportTaskRunner.class);
        CurrentUserService currentUserService = mock(CurrentUserService.class);
        ForgeTraceUserPrincipal principal = mock(ForgeTraceUserPrincipal.class);
        when(principal.getUsername()).thenReturn("admin@forgetrace.local");
        when(currentUserService.requirePrincipal()).thenReturn(principal);
        when(currentUserService.requireUserId()).thenReturn(1L);
        service = new ReportService(runner, mock(AuditLogCsvExporter.class), mock(AccessGuard.class),
                currentUserService, mock(AuditService.class), exportDir.toString(), "Asia/Kolkata");
    }

    @Test
    void validRequestIsQueuedOnBackgroundRunner() {
        ReportJob job = service.request(ReportType.ORDERS, ReportFormat.PDF, LocalDate.of(2026, 11, 1), LocalDate.of(2026, 11, 24));

        assertThat(job.getStatus()).isEqualTo(ReportJob.Status.QUEUED);
        assertThat(job.getRequestedBy()).isEqualTo("admin@forgetrace.local");
        assertThat(service.recentJobs()).containsExactly(job);
        verify(runner).run(job);
    }

    @Test
    void toDateBeforeFromIsRejected() {
        assertThatThrownBy(() -> service.request(ReportType.ORDERS, ReportFormat.CSV,
                LocalDate.of(2026, 11, 24), LocalDate.of(2026, 11, 1)))
                .isInstanceOf(BusinessRuleException.class);
        verify(runner, never()).run(any());
    }

    @Test
    void rangeLongerThanOneYearIsRejected() {
        assertThatThrownBy(() -> service.request(ReportType.PAYMENTS, ReportFormat.CSV,
                LocalDate.of(2024, 1, 1), LocalDate.of(2026, 1, 1)))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("one year");
    }

    @Test
    void pathTraversalInDownloadIsBlocked() {
        assertThatThrownBy(() -> service.resolveDownload("../pom.xml")).isInstanceOf(ResourceNotFoundException.class);
        assertThatThrownBy(() -> service.resolveDownload("..\\secret.txt")).isInstanceOf(ResourceNotFoundException.class);
        assertThatThrownBy(() -> service.resolveDownload("missing.pdf")).isInstanceOf(ResourceNotFoundException.class);
    }

    @Test
    void existingExportCanBeDownloaded() throws Exception {
        Path file = Files.writeString(exportDir.resolve("report-orders-1.csv"), "a,b");

        assertThat(service.resolveDownload("report-orders-1.csv")).isEqualTo(file.toAbsolutePath().normalize());
        assertThat(service.files()).extracting(ReportService.FileRow::name).containsExactly("report-orders-1.csv");
    }
}