package com.forgetrace.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Currency;
import java.util.Locale;

/**
 * Used in HTML pages as ${@fmt.dateTime(...)} and ${@fmt.money(...)}.
 * Data is stored in UTC; it is shown in the display time zone (India by default).
 */
@Component("fmt")
public class DisplayFormatter {

    private static final DateTimeFormatter DATE_TIME = DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm");
    private static final DateTimeFormatter DATE = DateTimeFormatter.ofPattern("dd MMM yyyy");
    private static final Locale INDIA = Locale.of("en", "IN");
    private static final String EMPTY = "—";

    private final ZoneId zone;

    public DisplayFormatter(@Value("${app.display-zone:Asia/Kolkata}") String zoneId) {
        this.zone = ZoneId.of(zoneId);
    }

    public String dateTime(Instant instant) {
        return instant == null ? EMPTY : DATE_TIME.format(instant.atZone(zone));
    }

    public String date(Instant instant) {
        return instant == null ? EMPTY : DATE.format(instant.atZone(zone));
    }

    public String localDate(LocalDate date) {
        return date == null ? EMPTY : DATE.format(date);
    }

    public String money(BigDecimal amount, String currencyCode) {
        if (amount == null) {
            return EMPTY;
        }
        NumberFormat format = NumberFormat.getCurrencyInstance(INDIA);
        format.setCurrency(Currency.getInstance(currencyCode == null ? "INR" : currencyCode));
        return format.format(amount);
    }

    public String timeLeft(Instant deadline) {
        if (deadline == null) {
            return EMPTY;
        }
        Duration left = Duration.between(Instant.now(), deadline);
        if (left.isNegative() || left.isZero()) {
            return "Closed";
        }
        if (left.toDays() >= 1) {
            return left.toDays() + (left.toDays() == 1 ? " day left" : " days left");
        }
        long hours = Math.max(1, left.toHours());
        return hours + (hours == 1 ? " hour left" : " hours left");
    }

    public String rating(Double value) {
        return value == null ? null : String.format(Locale.ROOT, "%.1f", value);
    }
}