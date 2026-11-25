package com.forgetrace.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

public class AllowedFileTypeValidator implements ConstraintValidator<AllowedFileType, MultipartFile> {

    private Set<String> allowedExtensions;
    private long maxBytes;

    @Override
    public void initialize(AllowedFileType annotation) {
        this.allowedExtensions = Arrays.stream(annotation.extensions())
                .map(e -> e.toLowerCase(Locale.ROOT))
                .collect(Collectors.toSet());
        this.maxBytes = annotation.maxSizeMb() * 1024 * 1024;
    }

    @Override
    public boolean isValid(MultipartFile file, ConstraintValidatorContext context) {
        if (file == null || file.isEmpty()) {
            return true;
        }

        String extension = extensionOf(file.getOriginalFilename());
        if (!allowedExtensions.contains(extension)) {
            return fail(context, "Only these file types are allowed: " + String.join(", ", allowedExtensions));
        }
        if (file.getSize() > maxBytes) {
            return fail(context, "File is too large. Maximum size is " + (maxBytes / (1024 * 1024)) + " MB");
        }
        return true;
    }

    static String extensionOf(String filename) {
        if (filename == null) {
            return "";
        }
        int dot = filename.lastIndexOf('.');
        return dot < 0 ? "" : filename.substring(dot + 1).toLowerCase(Locale.ROOT);
    }

    private boolean fail(ConstraintValidatorContext context, String message) {
        context.disableDefaultConstraintViolation();
        context.buildConstraintViolationWithTemplate(message).addConstraintViolation();
        return false;
    }
}