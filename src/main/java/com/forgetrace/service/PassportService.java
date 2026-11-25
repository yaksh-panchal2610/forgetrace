package com.forgetrace.service;

import com.forgetrace.dto.response.PassportView;
import com.forgetrace.entity.Batch;
import com.forgetrace.entity.Inspection;
import com.forgetrace.entity.ProductPassport;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.PassportVisibility;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.PassportMapper;
import com.forgetrace.qr.PassportTokenGenerator;
import com.forgetrace.qr.QrCodeGenerator;
import com.forgetrace.repository.InspectionRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.storage.FileStorageService;
import com.forgetrace.storage.StoredFile;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;
import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class PassportService {

    private static final int QR_SIZE = 360;

    private final ProductPassportRepository passportRepository;
    private final InspectionRepository inspectionRepository;
    private final PassportTokenGenerator tokenGenerator;
    private final QrCodeGenerator qrCodeGenerator;
    private final FileStorageService storage;
    private final PassportMapper mapper;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    @Transactional
    public ProductPassport createForBatch(Batch batch) {
        Optional<ProductPassport> existing = passportRepository.findByBatch_Id(batch.getId());
        if (existing.isPresent()) {
            return existing.get();
        }
        UUID token = tokenGenerator.newToken();
        ProductPassport passport = new ProductPassport();
        passport.setBatch(batch);
        passport.setPublicToken(token);
        passport.setVisibilityStatus(PassportVisibility.PUBLIC);
        passport.setPublishedAt(Instant.now());
        try {
            StoredFile qr = storage.store("passports", "png", "image/png", qrCodeGenerator.png(publicUrl(token), QR_SIZE));
            passport.setQrFileKey(qr.objectKey());
        } catch (IOException ex) {
            log.warn("QR image for batch {} could not be stored; it will be generated on request", batch.getBatchNumber());
        }
        passportRepository.save(passport);
        log.info("Passport created for batch {}", batch.getBatchNumber());
        return passport;
    }

    @Transactional(readOnly = true)
    public Optional<PassportView> publicView(UUID token) {
        return passportRepository.findByPublicToken(token).map(passport -> {
            Inspection inspection = inspectionRepository
                    .findFirstByBatch_IdAndStatusOrderByInspectedAtDesc(passport.getBatch().getId(), InspectionStatus.PASSED)
                    .orElse(null);
            return mapper.toView(passport, inspection);
        });
    }

    @Transactional(readOnly = true)
    public byte[] qrPng(UUID token) {
        ProductPassport passport = passportRepository.findByPublicToken(token)
                .orElseThrow(() -> new ResourceNotFoundException("Passport not found."));
        if (passport.getQrFileKey() != null) {
            try (InputStream in = storage.load(passport.getQrFileKey())) {
                return in.readAllBytes();
            } catch (IOException ex) {
                log.warn("Stored QR missing for passport {}, regenerating", token);
            }
        }
        return qrCodeGenerator.png(publicUrl(token), QR_SIZE);
    }

    public String publicUrl(UUID token) {
        return baseUrl + "/p/" + token;
    }
}