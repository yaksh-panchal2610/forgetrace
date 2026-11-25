package com.forgetrace.dto.response;

import java.util.List;

/** Shown after a CSV upload: how many rows were imported and what was wrong with the others. */
public record CsvImportResult(int totalRows, int imported, List<RowError> errors) {

    public record RowError(int lineNumber, String message) {
    }

    public int failed() {
        return errors.size();
    }

    public boolean hasErrors() {
        return !errors.isEmpty();
    }
}