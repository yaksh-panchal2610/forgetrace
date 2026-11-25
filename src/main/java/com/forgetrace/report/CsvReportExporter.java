package com.forgetrace.report;

import com.forgetrace.fileio.AbstractCsvHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;

@Component
public class CsvReportExporter implements ReportExporter {

    @Override
    public ReportFormat format() {
        return ReportFormat.CSV;
    }

    @Override
    public void export(ReportData data, Path file) throws IOException {
        AbstractCsvHandler<List<String>> handler = new AbstractCsvHandler<>() {
            @Override
            protected List<String> headers() {
                return data.headers();
            }

            @Override
            protected List<String> fromRow(Map<String, String> row) {
                throw new UnsupportedOperationException("Reports are export-only.");
            }

            @Override
            protected List<String> toRow(List<String> item) {
                return item;
            }
        };
        handler.writeToFile(file, data.rows());
    }
}