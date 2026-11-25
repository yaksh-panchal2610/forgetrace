package com.forgetrace.report;

import java.io.IOException;
import java.nio.file.Path;

public interface ReportExporter {

    ReportFormat format();

    void export(ReportData data, Path file) throws IOException;
}