package com.forgetrace.dto.response;

import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RfqStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

public record BuyerDashboardView(
        String organizationName,
        long openRfqs,
        long activeOrders,
        long completedOrders,
        List<RecentRfq> recentRfqs,
        List<RecentOrder> recentOrders
) {
    public record RecentRfq(Long id, String rfqNumber, String title, String processName,
                            RfqStatus status, Instant quoteDeadline) {
    }

    /** counterpartyName = manufacturer for buyers, buyer for manufacturers. */
    public record RecentOrder(Long id, String orderNumber, String counterpartyName,
                              OrderStatus status, BigDecimal totalAmount, String currency) {
    }
}