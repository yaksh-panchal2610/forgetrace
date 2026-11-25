package com.forgetrace.payment;

public interface PaymentGateway {

    String name();

    GatewayResult charge(GatewayRequest request);
}