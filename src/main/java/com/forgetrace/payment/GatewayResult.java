package com.forgetrace.payment;

public record GatewayResult(boolean success, String providerReference, String failureReason) {

    public static GatewayResult ok(String providerReference) {
        return new GatewayResult(true, providerReference, null);
    }

    public static GatewayResult failed(String reason) {
        return new GatewayResult(false, null, reason);
    }
}