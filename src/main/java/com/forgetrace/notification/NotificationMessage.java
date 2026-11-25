package com.forgetrace.notification;

/** One message for one user. Immutable, so it is safe to pass between threads. */
public record NotificationMessage(
        Long userId,
        String email,
        String fullName,
        String title,
        String body,
        String linkUrl
) {
}