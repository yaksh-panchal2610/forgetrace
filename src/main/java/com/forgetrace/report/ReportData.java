package com.forgetrace.report;

import java.util.List;

public record ReportData(
        String title,
        String subtitle,
        List<String> summaryLines,
        List<String> headers,
        List<List<String>> rows
) {
}