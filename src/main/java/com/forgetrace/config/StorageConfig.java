package com.forgetrace.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

@Configuration
@EnableConfigurationProperties(StorageProperties.class)
public class StorageConfig {

    /**
     * Created only on AWS (app.storage.mode=s3).
     * No keys in code: on EC2 the SDK uses the instance's IAM role automatically.
     */
    @Bean
    @ConditionalOnProperty(name = "app.storage.mode", havingValue = "s3")
    public S3Client s3Client(StorageProperties properties) {
        return S3Client.builder()
                .region(Region.of(properties.getRegion()))
                .build();
    }
}