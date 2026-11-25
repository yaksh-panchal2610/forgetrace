package com.forgetrace.storage;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.UUID;


public interface FileStorageService {

    StoredFile store(String folder, String extension, String contentType, long sizeBytes, InputStream content) throws IOException;

    InputStream load(String objectKey) throws IOException;

    void delete(String objectKey) throws IOException;

    default StoredFile store(String folder, String extension, String contentType, byte[] bytes) throws IOException {
        return store(folder, extension, contentType, bytes.length, new ByteArrayInputStream(bytes));
    }

    /** e.g. "rfq-attachments/2026/11/3f2a...e1.pdf" - random name, never the user's file name. */
    static String newObjectKey(String folder, String extension) {
        LocalDate today = LocalDate.now();
        return String.format("%s/%d/%02d/%s.%s",
                folder, today.getYear(), today.getMonthValue(), UUID.randomUUID(), extension);
    }
}