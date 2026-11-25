package com.forgetrace.dto.response;

import com.forgetrace.enums.VerificationStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

public record ManufacturerDashboardView(
        String organizationName,
        VerificationStatus verificationStatus,
        long activeMachines,
        long totalMachines,
        long matchingOpenRfqs,
        long activeOrders,
        List<MatchingRfq> matchingRfqs,
        List<BuyerDashboardView.RecentOrder> recentOrders
) {
    public record MatchingRfq(Long id, String rfqNumber, String title, String buyerName,
                              String processName, String materialName,
                              BigDecimal quantity, String quantityUnit, Instant quoteDeadline) {
    }

    public boolean isVerified() {
        return verificationStatus == VerificationStatus.VERIFIED;
    }
}