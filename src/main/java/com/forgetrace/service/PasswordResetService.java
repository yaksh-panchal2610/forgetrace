package com.forgetrace.service;

import com.forgetrace.entity.PasswordResetToken;
import com.forgetrace.entity.User;
import com.forgetrace.exception.InvalidTokenException;
import com.forgetrace.repository.PasswordResetTokenRepository;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.Base64;
import java.util.HexFormat;
import java.util.Locale;
import java.util.Optional;

/**
 * Forgot-password flow.
 * - A random token is created and only its SHA-256 hash is stored.
 * - The token expires after 30 minutes and can be used once.
 * - The response never reveals whether an email is registered.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PasswordResetService {

    private static final Duration TOKEN_LIFETIME = Duration.ofMinutes(30);
    private static final SecureRandom RANDOM = new SecureRandom();

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuditService auditService;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    /** Development only: print the reset link in the console because no email server is set up yet. */
    @Value("${app.mail.log-links:false}")
    private boolean logLinks;

    @Transactional
    public void requestReset(String email) {
        String normalized = email.trim().toLowerCase(Locale.ROOT);
        Optional<User> found = userRepository.findByEmailIgnoreCase(normalized);
        if (found.isEmpty() || !found.get().getAccountStatus().canLogin()) {
            log.info("Password reset requested for an unknown or inactive account");
            return; // same response either way
        }
        User user = found.get();

        tokenRepository.deleteByUser_Id(user.getId()); // only one valid link at a time

        String rawToken = newRawToken();
        PasswordResetToken token = new PasswordResetToken();
        token.setUser(user);
        token.setTokenHash(hash(rawToken));
        token.setExpiresAt(Instant.now().plus(TOKEN_LIFETIME));
        tokenRepository.save(token);

        String link = baseUrl + "/auth/reset-password?token=" + rawToken;
        if (logLinks) {
            log.info("[DEV ONLY] Password reset link for {}: {}", normalized, link);
        }
        auditService.record(user.getId(), "PASSWORD_RESET_REQUESTED", "User", user.getId(), null);
    }

    @Transactional(readOnly = true)
    public boolean isTokenValid(String rawToken) {
        if (rawToken == null || rawToken.isBlank()) {
            return false;
        }
        return tokenRepository.findByTokenHash(hash(rawToken))
                .map(t -> t.isUsable(Instant.now()))
                .orElse(false);
    }

    @Transactional
    public void resetPassword(String rawToken, String newPassword) {
        Instant now = Instant.now();
        PasswordResetToken token = tokenRepository.findByTokenHash(hash(rawToken))
                .filter(t -> t.isUsable(now))
                .orElseThrow(InvalidTokenException::new);

        User user = token.getUser();
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        token.setUsedAt(now);

        auditService.record(user.getId(), "PASSWORD_RESET_COMPLETED", "User", user.getId(), null);
    }

    private static String newRawToken() {
        byte[] bytes = new byte[32];
        RANDOM.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    static String hash(String rawToken) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return HexFormat.of().formatHex(digest.digest(rawToken.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException ex) {
            throw new IllegalStateException("SHA-256 not available", ex);
        }
    }
}