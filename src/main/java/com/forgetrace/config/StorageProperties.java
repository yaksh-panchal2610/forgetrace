package com.forgetrace.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;

/** Reads every "app.storage.*" setting from application*.properties. */
@Getter
@Setter
@ConfigurationProperties(prefix = "app.storage")
public class StorageProperties {

    /** "local" (files on disk) or "s3" (AWS S3). */
    private String mode = "local";

    /** Folder used when mode = local. */
    private String localDir = "uploads";

    /** S3 bucket name when mode = s3. */
    private String bucket;

    private String region = "ap-south-1";

    private long maxFileSizeMb = 10;

    private List<String> allowedExtensions = List.of("pdf", "png", "jpg", "jpeg", "dxf", "step", "stp", "csv");
}