package com.forgetrace.enums;

public enum PaymentMethod {
    CARD("Card"),
    UPI("UPI"),
    NET_BANKING("Net banking"),
    WALLET("Wallet"),
    SANDBOX("Sandbox (test)");

    private final String label;

    PaymentMethod(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}