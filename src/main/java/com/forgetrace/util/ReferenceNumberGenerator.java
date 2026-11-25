package com.forgetrace.util;

import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.time.Year;
import java.time.ZoneOffset;

@Component
public class ReferenceNumberGenerator {

    private static final char[] ALPHABET = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ".toCharArray();
    private static final int LENGTH = 8;

    private final SecureRandom random = new SecureRandom();

    public String next(String prefix) {
        StringBuilder code = new StringBuilder(LENGTH);
        for (int i = 0; i < LENGTH; i++) {
            code.append(ALPHABET[random.nextInt(ALPHABET.length)]);
        }
        return prefix + "-" + Year.now(ZoneOffset.UTC).getValue() + "-" + code;
    }
}