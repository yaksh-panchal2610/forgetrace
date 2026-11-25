package com.forgetrace.report;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.EnumMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Slf4j
@Component
public class ReportTaskRunner {

    private static final DateTimeFormatter STAMP = DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss").withZone(ZoneOffset.UTC);

    private final ReportDataFactory dataFactory;
    private final Map<ReportFormat, ReportExporter> exporters = new EnumMap<>(ReportFormat.class);
    private final Path exportDirectory;

    public ReportTaskRunner(ReportDataFactory dataFactory, List<ReportExporter> exporterBeans,
                            @Value("${app.export-dir:exports}") String exportDirectory) {
        this.dataFactory = dataFactory;
        exporterBeans.forEach(e -> exporters.put(e.format(), e));
        this.exportDirectory = Paths.get(exportDirectory).toAbsolutePath().normalize();
    }

    @Async("taskExecutor")
    public void run(ReportJob job) {
        job.markRunning();
        long started = System.currentTimeMillis();
        try {
            ReportData data = dataFactory.build(job.getType(), job.getFrom(), job.getTo());
            Files.createDirectories(exportDirectory);
            String name = "report-" + job.getType().name().toLowerCase(Locale.ROOT) + "-" + STAMP.format(Instant.now())
                    + "-" + job.getId().substring(0, 6) + "." + job.getFormat().getExtension();
            exporters.get(job.getFormat()).export(data, exportDirectory.resolve(name));
            job.markDone(name);
            log.info("Report {} finished on {} in {} ms", name, Thread.currentThread().getName(),
                    System.currentTimeMillis() - started);
        } catch (Exception ex) {
            log.error("Report {} failed", job.getId(), ex);
            job.markFailed(ex.getMessage() == null ? ex.getClass().getSimpleName() : ex.getMessage());
        }
    }
}