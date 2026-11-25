package com.forgetrace.payment;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.regex.Pattern;

@Slf4j
@Component
public class SandboxPaymentGateway implements PaymentGateway {

    private static final Pattern UPI_ID = Pattern.compile("^[a-zA-Z0-9._-]{2,64}@[a-zA-Z]{2,32}$");
    private static final String ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    public String name() {
        return "SANDBOX";
    }

    @Override
    public GatewayResult charge(GatewayRequest request) {
        GatewayResult result = switch (request.method()) {
            case CARD -> card(request.cardNumber());
            case UPI -> upi(request.upiId());
            case NET_BANKING, WALLET -> GatewayResult.ok(newProviderReference());
            case SANDBOX -> GatewayResult.failed("Choose a payment method.");
        };
        log.info("Sandbox charge {} {} {} via {} -> {}", request.paymentReference(), request.amount(), request.currency(),
                request.method(), result.success() ? "SUCCESS" : "FAILED (" + result.failureReason() + ")");
        return result;
    }

    private GatewayResult card(String raw) {
        String digits = raw == null ? "" : raw.replaceAll("[\\s-]", "");
        if (!digits.matches("\\d{12,19}") || !passesLuhn(digits)) {
            return GatewayResult.failed("Card number is not valid.");
        }
        if (digits.endsWith("0002")) {
            return GatewayResult.failed("Card declined by the bank (sandbox test card).");
        }
        return GatewayResult.ok(newProviderReference());
    }

    private GatewayResult upi(String raw) {
        String id = raw == null ? "" : raw.trim();
        if (!UPI_ID.matcher(id).matches()) {
            return GatewayResult.failed("UPI ID is not valid. Example: name@okbank");
        }
        if (id.toLowerCase().startsWith("fail")) {
            return GatewayResult.failed("UPI request declined (sandbox test ID).");
        }
        return GatewayResult.ok(newProviderReference());
    }

    static boolean passesLuhn(String digits) {
        int sum = 0;
        boolean doubleIt = false;
        for (int i = digits.length() - 1; i >= 0; i--) {
            int d = digits.charAt(i) - '0';
            if (doubleIt) {
                d *= 2;
                if (d > 9) {
                    d -= 9;
                }
            }
            sum += d;
            doubleIt = !doubleIt;
        }
        return sum % 10 == 0;
    }

    private static String newProviderReference() {
        StringBuilder sb = new StringBuilder("sbx_");
        for (int i = 0; i < 14; i++) {
            sb.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }
}