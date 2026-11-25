package com.forgetrace.notification;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Email channel.
 * In this prototype no mail server is connected, so the email is written to the log
 * (app.mail.log-emails=true in development). In production this class would call
 * Amazon SES or an SMTP server.
 */
@Slf4j
@Component
public class EmailNotificationChannel extends AbstractNotificationChannel {

    @Value("${app.mail.log-emails:false}")
    private boolean logEmails;

    @Override
    public String name() {
        return "email";
    }

    @Override
    protected boolean isEnabled() {
        return logEmails;
    }

    @Override
    protected void deliver(NotificationMessage message) {
        log.info("[EMAIL - dev log only] thread={} to={} subject=\"{}\"",
                Thread.currentThread().getName(), message.email(), message.title());
    }
}