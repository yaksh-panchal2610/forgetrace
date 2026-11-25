package com.forgetrace.fileio;

import com.forgetrace.dto.response.CsvImportResult;
import com.forgetrace.exception.FileValidationException;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Generic CSV reader/writer. Subclasses only say WHICH columns exist and HOW one row
 * maps to an object (Template Method pattern).
 *
 * Supports quoted values ("Pune, MH") and escaped quotes (""). Each record must be on one line.
 */
public abstract class AbstractCsvHandler<T> {

    public static final int MAX_ROWS = 500;
    private static final char SEPARATOR = ',';

    /** One successfully parsed row and its line number in the file. */
    public record ParsedRow<R>(int lineNumber, R value) {
    }

    /** Everything read from a file: good rows and per-line errors. */
    public record ParseResult<R>(List<ParsedRow<R>> rows, List<CsvImportResult.RowError> errors) {
    }

    /** Thrown by fromRow() when a single row is invalid - the rest of the file continues. */
    public static class CsvRowException extends RuntimeException {
        public CsvRowException(String message) {
            super(message);
        }
    }

    // ---------- What subclasses must provide ----------

    /** Column names, in file order. */
    protected abstract List<String> headers();

    /** Columns that must exist in the header line. Default: all of them. */
    protected List<String> requiredHeaders() {
        return headers();
    }

    /** Convert one row (column name -> value) into an object. Throw CsvRowException if invalid. */
    protected abstract T fromRow(Map<String, String> row);

    /** Convert one object into column values, in the same order as headers(). */
    protected abstract List<String> toRow(T item);

    // ---------- Reading (LOAD) ----------

    public ParseResult<T> read(InputStream input) throws IOException {
        List<ParsedRow<T>> rows = new ArrayList<>();
        List<CsvImportResult.RowError> errors = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(input, StandardCharsets.UTF_8))) {
            String headerLine = reader.readLine();
            if (headerLine == null || headerLine.isBlank()) {
                throw new FileValidationException("The CSV file is empty.");
            }
            headerLine = stripByteOrderMark(headerLine);

            List<String> header = parseLine(headerLine).stream()
                    .map(h -> h.trim().toLowerCase(Locale.ROOT))
                    .toList();
            List<String> missing = requiredHeaders().stream().filter(h -> !header.contains(h)).toList();
            if (!missing.isEmpty()) {
                throw new FileValidationException("Missing column(s): " + String.join(", ", missing)
                        + ". Download the template to see the expected format.");
            }

            String line;
            int lineNumber = 1;
            int dataRows = 0;
            while ((line = reader.readLine()) != null) {
                lineNumber++;
                if (line.isBlank()) {
                    continue;
                }
                if (++dataRows > MAX_ROWS) {
                    errors.add(new CsvImportResult.RowError(lineNumber,
                            "Only the first " + MAX_ROWS + " rows are imported. Split the file and upload the rest."));
                    break;
                }
                List<String> values = parseLine(line);
                Map<String, String> row = new HashMap<>();
                for (int i = 0; i < header.size(); i++) {
                    row.put(header.get(i), i < values.size() ? values.get(i).trim() : "");
                }
                try {
                    rows.add(new ParsedRow<>(lineNumber, fromRow(row)));
                } catch (CsvRowException ex) {
                    errors.add(new CsvImportResult.RowError(lineNumber, ex.getMessage()));
                }
            }
        }
        return new ParseResult<>(rows, errors);
    }

    // ---------- Writing (SAVE) ----------

    public void write(Writer writer, Collection<T> items) throws IOException {
        writeLine(writer, headers());
        for (T item : items) {
            writeLine(writer, toRow(item));
        }
        writer.flush();
    }

    /** Saves the CSV to a real file on disk and returns its path. */
    public Path writeToFile(Path file, Collection<T> items) throws IOException {
        if (file.getParent() != null) {
            Files.createDirectories(file.getParent());
        }
        try (BufferedWriter writer = Files.newBufferedWriter(file, StandardCharsets.UTF_8)) {
            write(writer, items);
        }
        return file;
    }

    // ---------- CSV helpers ----------

    static List<String> parseLine(String line) {
        List<String> values = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;

        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (inQuotes) {
                if (c == '"') {
                    if (i + 1 < line.length() && line.charAt(i + 1) == '"') {
                        current.append('"'); // "" inside quotes = one quote
                        i++;
                    } else {
                        inQuotes = false;
                    }
                } else {
                    current.append(c);
                }
            } else if (c == '"') {
                inQuotes = true;
            } else if (c == SEPARATOR) {
                values.add(current.toString());
                current.setLength(0);
            } else {
                current.append(c);
            }
        }
        values.add(current.toString());
        return values;
    }

    /**
     * Quotes values that need it. Also blocks "CSV injection": a cell starting with = + - @
     * could run as a formula in Excel, so it gets a leading apostrophe.
     */
    static String escape(String value) {
        if (value == null) {
            return "";
        }
        String result = value;
        if (!result.isEmpty() && "=+-@".indexOf(result.charAt(0)) >= 0) {
            result = "'" + result;
        }
        if (result.contains(",") || result.contains("\"") || result.contains("\n") || result.contains("\r")) {
            result = "\"" + result.replace("\"", "\"\"") + "\"";
        }
        return result;
    }

    private static void writeLine(Writer writer, List<String> values) throws IOException {
        List<String> escaped = values.stream().map(AbstractCsvHandler::escape).toList();
        writer.write(String.join(String.valueOf(SEPARATOR), escaped));
        writer.write("\r\n");
    }

    private static String stripByteOrderMark(String line) {
        return line.startsWith("\uFEFF") ? line.substring(1) : line;
    }
}