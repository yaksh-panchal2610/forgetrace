package com.forgetrace.service;

import com.forgetrace.entity.Batch;
import com.forgetrace.entity.ProductPassport;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PassportVisibility;
import com.forgetrace.mapper.PassportMapper;
import com.forgetrace.qr.PassportTokenGenerator;
import com.forgetrace.qr.QrCodeGenerator;
import com.forgetrace.repository.InspectionRepository;
import com.forgetrace.repository.ProductPassportRepository;
import com.forgetrace.storage.FileStorageService;
import com.forgetrace.support.TestData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.util.ReflectionTestUtils;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class PassportServiceTest {

    @Mock ProductPassportRepository passportRepository;
    @Mock InspectionRepository inspectionRepository;
    @Mock PassportTokenGenerator tokenGenerator;
    @Mock QrCodeGenerator qrCodeGenerator;
    @Mock FileStorageService storage;
    @Mock PassportMapper mapper;

    @InjectMocks PassportService service;

    private final UUID token = UUID.fromString("3f2a6c1e-8a7b-4d2e-9b1f-0c5d7e8f9a10");

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(service, "baseUrl", "http://localhost:8080");
        when(qrCodeGenerator.png(anyString(), anyInt())).thenReturn(new byte[]{1, 2, 3});
    }

    @Test
    @DisplayName("FT-031: unknown passport token shows nothing")
    void unknownTokenIsEmpty() {
        when(passportRepository.findByPublicToken(token)).thenReturn(Optional.empty());

        assertThat(service.publicView(token)).isEmpty();
        verify(mapper, never()).toView(any(), any());
    }

    @Test
    void newPassportIsPublicWithRandomToken() throws IOException {
        Batch batch = TestData.batch(3L, BatchStatus.APPROVED, TestData.order(1L, OrderStatus.QUALITY_CHECK), "50");
        when(passportRepository.findByBatch_Id(3L)).thenReturn(Optional.empty());
        when(tokenGenerator.newToken()).thenReturn(token);
        when(storage.store(anyString(), anyString(), anyString(), any(byte[].class))).thenThrow(new IOException("disk full"));

        ProductPassport passport = service.createForBatch(batch);

        assertThat(passport.getPublicToken()).isEqualTo(token);
        assertThat(passport.getVisibilityStatus()).isEqualTo(PassportVisibility.PUBLIC);
        assertThat(passport.getPublishedAt()).isNotNull();
        verify(qrCodeGenerator).png("http://localhost:8080/p/" + token, 360);
        verify(passportRepository).save(passport);
    }

    @Test
    void secondCallForSameBatchReturnsExistingPassport() {
        Batch batch = TestData.batch(3L, BatchStatus.APPROVED, TestData.order(1L, OrderStatus.QUALITY_CHECK), "50");
        ProductPassport existing = new ProductPassport();
        when(passportRepository.findByBatch_Id(3L)).thenReturn(Optional.of(existing));

        assertThat(service.createForBatch(batch)).isSameAs(existing);
        verify(passportRepository, never()).save(any());
    }

    @Test
    void qrIsRegeneratedWhenNoStoredImage() {
        ProductPassport passport = new ProductPassport();
        passport.setPublicToken(token);
        when(passportRepository.findByPublicToken(token)).thenReturn(Optional.of(passport));

        assertThat(service.qrPng(token)).containsExactly(1, 2, 3);
        verify(qrCodeGenerator).png("http://localhost:8080/p/" + token, 360);
    }
}