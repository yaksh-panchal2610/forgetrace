package com.forgetrace.report;

import lombok.Getter;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Getter
public class ReportJob {

    public enum Status { QUEUED, RUNNING, DONE, FAILED }

    private final String id = UUID.randomUUID().toString();
    private final ReportType type;
    private final ReportFormat format;
    private final LocalDate from;
    private final LocalDate to;
    private final String requestedBy;
    private final Instant createdAt = Instant.now();

    private volatile Status status = Status.QUEUED;
    private volatile String fileName;
    private volatile String error;
    private volatile Instant finishedAt;

    public ReportJob(ReportType type, ReportFormat format, LocalDate from, LocalDate to, String requestedBy) {
        this.type = type;
        this.format = format;
        this.from = from;
        this.to = to;
        this.requestedBy = requestedBy;
    }

    public void markRunning() {
        status = Status.RUNNING;
    }

    public void markDone(String generatedFile) {
        fileName = generatedFile;
        finishedAt = Instant.now();
        status = Status.DONE;
    }

    public void markFailed(String message) {
        error = message;
        finishedAt = Instant.now();
        status = Status.FAILED;
    }

    public boolean isFinished() {
        return status == Status.DONE || status == Status.FAILED;
    }
}