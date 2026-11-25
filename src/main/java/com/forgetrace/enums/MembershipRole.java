package com.forgetrace.enums;

public enum MembershipRole {
    OWNER("Owner"),
    ADMIN("Admin"),
    MEMBER("Member");

    private final String label;

    MembershipRole(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}