package com.forgetrace.dto.response;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

public record AdminDashboardView(
        long pendingVerifications,
        long verifiedManufacturers,
        long activeUsers,
        long suspendedUsers,
        long activeOrders,
        long openDisputes,
        long activeRecalls,
        long awaitingInspection,
        long newContacts,
        BigDecimal revenue14d,
        List<String> statusLabels,
        List<Long> statusCounts,
        List<String> dayLabels,
        List<BigDecimal> dayAmounts,
        List<AuditRow> recentActivity
) {
    public record AuditRow(Instant time, String actor, String action, String entityType, Long entityId,
                           String details, String ipAddress) {
    }
}