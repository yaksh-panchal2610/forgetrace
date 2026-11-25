package com.forgetrace.report;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

class ReportExporterTest {

    @TempDir
    Path tempDir;

    private ReportData sample(int rows) {
        List<List<String>> data = new ArrayList<>();
        for (int i = 1; i <= rows; i++) {
            data.add(List.of("ORD-" + i, "Pune · Maharashtra ₹", "=cmd", "Line, " + i));
        }
        return new ReportData("Test report", "Period test", List.of("Rows: " + rows),
                List.of("Order", "City", "Formula", "Comma"), data);
    }

    @Test
    void pdfHasMultiplePagesAndSurvivesNonAsciiText() throws Exception {
        Path file = tempDir.resolve("r.pdf");
        new PdfReportExporter().export(sample(80), file);
        assertThat(new String(Files.readAllBytes(file), 0, 4, StandardCharsets.US_ASCII)).isEqualTo("%PDF");
        try (PDDocument doc = Loader.loadPDF(file.toFile())) {
            assertThat(doc.getNumberOfPages()).isGreaterThanOrEqualTo(2);
        }
    }

    @Test
    void csvHasHeaderAndEscapesCells() throws Exception {
        Path file = tempDir.resolve("r.csv");
        new CsvReportExporter().export(sample(2), file);
        List<String> lines = Files.readAllLines(file, StandardCharsets.UTF_8);
        assertThat(lines).hasSize(3);
        assertThat(lines.get(0)).isEqualTo("Order,City,Formula,Comma");
        assertThat(lines.get(1)).contains("'=cmd").contains("\"Line, 1\"");
    }
}