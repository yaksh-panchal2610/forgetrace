package com.forgetrace.report;

public enum ReportFormat {
    PDF("PDF", "pdf"),
    CSV("CSV (Excel)", "csv");

    private final String label;
    private final String extension;

    ReportFormat(String label, String extension) {
        this.label = label;
        this.extension = extension;
    }

    public String getLabel() {
        return label;
    }

    public String getExtension() {
        return extension;
    }
}