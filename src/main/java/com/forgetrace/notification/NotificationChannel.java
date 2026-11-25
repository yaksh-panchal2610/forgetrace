package com.forgetrace.notification;

/** A way of delivering a notification (in-app, email, SMS...). */
public interface NotificationChannel {

    String name();

    void send(NotificationMessage message);
}