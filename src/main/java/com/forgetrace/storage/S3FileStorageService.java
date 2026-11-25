package com.forgetrace.storage;

import com.forgetrace.config.StorageProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.ServerSideEncryption;

import java.io.InputStream;

@Service
@RequiredArgsConstructor
@ConditionalOnProperty(name = "app.storage.mode", havingValue = "s3")
public class S3FileStorageService implements FileStorageService {

    private final S3Client s3Client;
    private final StorageProperties properties;

    @Override
    public StoredFile store(String folder, String extension, String contentType, long sizeBytes, InputStream content) {
        String key = FileStorageService.newObjectKey(folder, extension);
        PutObjectRequest request = PutObjectRequest.builder()
                .bucket(properties.getBucket())
                .key(key)
                .contentType(contentType)
                .serverSideEncryption(ServerSideEncryption.AES256)
                .build();
        s3Client.putObject(request, RequestBody.fromInputStream(content, sizeBytes));
        return new StoredFile(properties.getBucket(), key, sizeBytes);
    }

    @Override
    public InputStream load(String objectKey) {
        return s3Client.getObject(GetObjectRequest.builder()
                .bucket(properties.getBucket())
                .key(objectKey)
                .build());
    }

    @Override
    public void delete(String objectKey) {
        s3Client.deleteObject(DeleteObjectRequest.builder()
                .bucket(properties.getBucket())
                .key(objectKey)
                .build());
    }
}