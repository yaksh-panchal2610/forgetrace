package com.forgetrace.storage;

/** Where a file was saved. */
public record StoredFile(String bucket, String objectKey, long sizeBytes) {
}