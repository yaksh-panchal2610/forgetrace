package com.forgetrace.notification;

import lombok.extern.slf4j.Slf4j;

/**
 * Shared behaviour for every channel: a disabled channel does nothing, and a failure in one
 * channel is logged but never breaks the business action (e.g. creating the RFQ) or other channels.
 */
@Slf4j
public abstract class AbstractNotificationChannel implements NotificationChannel {

    @Override
    public final void send(NotificationMessage message) {
        if (!isEnabled()) {
            return;
        }
        try {
            deliver(message);
        } catch (RuntimeException ex) {
            log.warn("{} notification to user {} failed: {}", name(), message.userId(), ex.getMessage());
        }
    }

    protected boolean isEnabled() {
        return true;
    }

    /** The actual delivery - implemented by each channel. */
    protected abstract void deliver(NotificationMessage message);
}