package com.forgetrace.payment;

import com.forgetrace.enums.PaymentMethod;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

class SandboxPaymentGatewayTest {

    private final SandboxPaymentGateway gateway = new SandboxPaymentGateway();

    private GatewayRequest request(PaymentMethod method, String card, String upi) {
        return new GatewayRequest("PAY-T1", new BigDecimal("100.00"), "INR", method, card, upi);
    }

    @Test
    void approvedTestCardSucceeds() {
        GatewayResult r = gateway.charge(request(PaymentMethod.CARD, "4111 1111 1111 1111", null));
        assertThat(r.success()).isTrue();
        assertThat(r.providerReference()).startsWith("sbx_");
    }

    @Test
    void declineTestCardFails() {
        GatewayResult r = gateway.charge(request(PaymentMethod.CARD, "4000-0000-0000-0002", null));
        assertThat(r.success()).isFalse();
        assertThat(r.failureReason()).contains("declined");
    }

    @Test
    void cardFailingLuhnCheckIsInvalid() {
        GatewayResult r = gateway.charge(request(PaymentMethod.CARD, "4111 1111 1111 1112", null));
        assertThat(r.success()).isFalse();
        assertThat(r.failureReason()).contains("not valid");
    }

    @Test
    void upiSuccessAndFailureIds() {
        assertThat(gateway.charge(request(PaymentMethod.UPI, null, "success@okbank")).success()).isTrue();
        assertThat(gateway.charge(request(PaymentMethod.UPI, null, "fail@okbank")).success()).isFalse();
        assertThat(gateway.charge(request(PaymentMethod.UPI, null, "no-at-sign")).success()).isFalse();
    }

    @Test
    void netBankingAndWalletSucceed() {
        assertThat(gateway.charge(request(PaymentMethod.NET_BANKING, null, null)).success()).isTrue();
        assertThat(gateway.charge(request(PaymentMethod.WALLET, null, null)).success()).isTrue();
    }

    @Test
    void luhnAlgorithm() {
        assertThat(SandboxPaymentGateway.passesLuhn("4111111111111111")).isTrue();
        assertThat(SandboxPaymentGateway.passesLuhn("4000000000000002")).isTrue();
        assertThat(SandboxPaymentGateway.passesLuhn("1234567812345678")).isFalse();
    }
}