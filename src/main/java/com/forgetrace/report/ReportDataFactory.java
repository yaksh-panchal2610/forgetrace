package com.forgetrace.report;

import com.forgetrace.entity.Inspection;
import com.forgetrace.entity.Payment;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.repository.InspectionRepository;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class ReportDataFactory {

    private static final DateTimeFormatter DATE_TIME = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm", Locale.ENGLISH);
    private static final DateTimeFormatter DATE = DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.ENGLISH);

    private final ProductionOrderRepository orderRepository;
    private final PaymentRepository paymentRepository;
    private final InspectionRepository inspectionRepository;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    @Transactional(readOnly = true)
    public ReportData build(ReportType type, LocalDate from, LocalDate to) {
        ZoneId zone = ZoneId.of(displayZone);
        Instant start = from.atStartOfDay(zone).toInstant();
        Instant end = to.plusDays(1).atStartOfDay(zone).toInstant();
        String subtitle = "Period " + DATE.format(from) + " to " + DATE.format(to)
                + "  |  Generated " + DATE_TIME.withZone(zone).format(Instant.now()) + " (" + displayZone + ")";
        return switch (type) {
            case ORDERS -> orders(start, end, zone, subtitle);
            case PAYMENTS -> payments(start, end, zone, subtitle);
            case QUALITY -> quality(start, end, zone, subtitle);
        };
    }

    private ReportData orders(Instant start, Instant end, ZoneId zone, String subtitle) {
        List<ProductionOrder> orders = orderRepository.findAll(Sort.by("createdAt")).stream()
                .filter(o -> within(o.getCreatedAt(), start, end)).toList();
        List<List<String>> rows = new ArrayList<>();
        for (ProductionOrder o : orders) {
            rows.add(List.of(o.getOrderNumber(), DATE_TIME.withZone(zone).format(o.getCreatedAt()),
                    o.getBuyerOrganization().getDisplayName(), o.getManufacturerOrganization().getDisplayName(),
                    o.getRfq().getTitle(), o.getQuantity().stripTrailingZeros().toPlainString() + " " + o.getRfq().getQuantityUnit(),
                    money(o.getTotalAmount(), o.getCurrency()), o.getStatus().getLabel()));
        }
        BigDecimal value = orders.stream().filter(o -> o.getStatus() != OrderStatus.CANCELLED)
                .map(ProductionOrder::getTotalAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        Map<OrderStatus, Long> byStatus = orders.stream().collect(Collectors.groupingBy(ProductionOrder::getStatus,
                () -> new EnumMap<>(OrderStatus.class), Collectors.counting()));
        String breakdown = byStatus.entrySet().stream().map(e -> e.getKey().getLabel() + " " + e.getValue())
                .collect(Collectors.joining(", "));
        return new ReportData("ForgeTrace - Orders summary", subtitle,
                List.of("Orders: " + orders.size(),
                        "Order value (excluding cancelled): " + money(value, "INR"),
                        "By status: " + (breakdown.isEmpty() ? "-" : breakdown)),
                List.of("Order", "Created", "Buyer", "Manufacturer", "Item", "Quantity", "Amount", "Status"), rows);
    }

    private ReportData payments(Instant start, Instant end, ZoneId zone, String subtitle) {
        List<Payment> payments = paymentRepository.findAll(Sort.by("createdAt")).stream()
                .filter(p -> within(p.getCreatedAt(), start, end)).toList();
        List<List<String>> rows = new ArrayList<>();
        for (Payment p : payments) {
            rows.add(List.of(p.getPaymentReference(), DATE_TIME.withZone(zone).format(p.getCreatedAt()),
                    p.getProductionOrder().getOrderNumber(), p.getProductionOrder().getBuyerOrganization().getDisplayName(),
                    p.getPaymentMethod().getLabel(), money(p.getAmount(), p.getCurrency()), p.getStatus().getLabel(),
                    p.getFailureReason() == null ? "" : p.getFailureReason()));
        }
        List<Payment> ok = payments.stream().filter(p -> p.getStatus() == PaymentStatus.SUCCEEDED).toList();
        long failed = payments.stream().filter(p -> p.getStatus() == PaymentStatus.FAILED).count();
        BigDecimal collected = ok.stream().map(Payment::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        return new ReportData("ForgeTrace - Payments", subtitle,
                List.of("Attempts: " + payments.size() + "  |  Successful: " + ok.size() + "  |  Failed: " + failed,
                        "Collected: " + money(collected, "INR")),
                List.of("Reference", "Date", "Order", "Buyer", "Method", "Amount", "Status", "Failure reason"), rows);
    }

    private ReportData quality(Instant start, Instant end, ZoneId zone, String subtitle) {
        List<Inspection> inspections = inspectionRepository.findAll(Sort.by("createdAt")).stream()
                .filter(i -> within(i.getInspectedAt(), start, end)).toList();
        List<List<String>> rows = new ArrayList<>();
        for (Inspection i : inspections) {
            long failedMeasurements = i.getMeasurements().stream().filter(m -> !m.isPass()).count();
            rows.add(List.of(DATE_TIME.withZone(zone).format(i.getInspectedAt()), i.getBatch().getBatchNumber(),
                    i.getBatch().getProductionOrder().getManufacturerOrganization().getDisplayName(),
                    i.getInspectionType().getLabel(), i.getInspector().getFullName(),
                    String.valueOf(i.getMeasurements().size()), String.valueOf(failedMeasurements), i.getStatus().getLabel()));
        }
        long passed = inspections.stream().filter(i -> i.getStatus() == InspectionStatus.PASSED).count();
        long failed = inspections.stream().filter(i -> i.getStatus() == InspectionStatus.FAILED).count();
        long hold = inspections.stream().filter(i -> i.getStatus() == InspectionStatus.ON_HOLD).count();
        long decided = passed + failed;
        String rate = decided == 0 ? "-" : Math.round(passed * 100.0 / decided) + "%";
        return new ReportData("ForgeTrace - Quality inspections", subtitle,
                List.of("Inspections: " + inspections.size() + "  |  Passed: " + passed + "  |  Failed: " + failed + "  |  On hold: " + hold,
                        "Pass rate (passed / decided): " + rate),
                List.of("Inspected", "Batch", "Manufacturer", "Type", "Inspector", "Measurements", "Out of tolerance", "Result"), rows);
    }

    private static boolean within(Instant t, Instant start, Instant end) {
        return t != null && !t.isBefore(start) && t.isBefore(end);
    }

    private static String money(BigDecimal amount, String currency) {
        return currency + " " + amount.setScale(2, RoundingMode.HALF_UP).toPlainString();
    }
}