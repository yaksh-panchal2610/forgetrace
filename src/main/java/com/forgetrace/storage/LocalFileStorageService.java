package com.forgetrace.storage;

import com.forgetrace.config.StorageProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/** Saves files in a folder on this computer. Used in development (app.storage.mode=local). */
@Slf4j
@Service
@ConditionalOnProperty(name = "app.storage.mode", havingValue = "local", matchIfMissing = true)
public class LocalFileStorageService implements FileStorageService {

    private static final String BUCKET_NAME = "local";

    private final Path root;

    public LocalFileStorageService(StorageProperties properties) throws IOException {
        this.root = Paths.get(properties.getLocalDir()).toAbsolutePath().normalize();
        Files.createDirectories(root);
        log.info("Local file storage folder: {}", root);
    }

    @Override
    public StoredFile store(String folder, String extension, String contentType, long sizeBytes, InputStream content)
            throws IOException {
        String key = FileStorageService.newObjectKey(folder, extension);
        Path target = resolve(key);
        Files.createDirectories(target.getParent());
        long written = Files.copy(content, target, StandardCopyOption.REPLACE_EXISTING);
        return new StoredFile(BUCKET_NAME, key, written);
    }

    @Override
    public InputStream load(String objectKey) throws IOException {
        Path file = resolve(objectKey);
        if (!Files.exists(file)) {
            throw new IOException("File not found in storage: " + objectKey);
        }
        return Files.newInputStream(file);
    }

    @Override
    public void delete(String objectKey) throws IOException {
        Files.deleteIfExists(resolve(objectKey));
    }

    /** Blocks path traversal such as "../../windows/system32". */
    private Path resolve(String objectKey) throws IOException {
        Path resolved = root.resolve(objectKey).normalize();
        if (!resolved.startsWith(root)) {
            throw new IOException("Invalid storage path");
        }
        return resolved;
    }
}