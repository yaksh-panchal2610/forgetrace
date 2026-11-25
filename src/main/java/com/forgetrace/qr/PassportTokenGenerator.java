package com.forgetrace.qr;

import com.forgetrace.repository.ProductPassportRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class PassportTokenGenerator {

    private final ProductPassportRepository passportRepository;

    public UUID newToken() {
        UUID token;
        do {
            token = UUID.randomUUID();
        } while (passportRepository.findByPublicToken(token).isPresent());
        return token;
    }
}