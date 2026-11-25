package com.forgetrace.notification;

import com.forgetrace.entity.Notification;
import com.forgetrace.repository.NotificationRepository;
import com.forgetrace.repository.UserRepository;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

/** Saves the notification so it appears under the bell icon. */
@Component
public class InAppNotificationChannel extends AbstractNotificationChannel {

    private static final int MAX_TITLE = 160;

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;
    private final TransactionTemplate transactionTemplate;

    public InAppNotificationChannel(NotificationRepository notificationRepository,
                                    UserRepository userRepository,
                                    PlatformTransactionManager transactionManager) {
        this.notificationRepository = notificationRepository;
        this.userRepository = userRepository;
        this.transactionTemplate = new TransactionTemplate(transactionManager);
    }

    @Override
    public String name() {
        return "in-app";
    }

    @Override
    protected void deliver(NotificationMessage message) {
        // Works both inside a caller's transaction and from a background thread (opens its own)
        transactionTemplate.executeWithoutResult(status -> {
            Notification notification = new Notification();
            notification.setUser(userRepository.getReferenceById(message.userId()));
            notification.setTitle(truncate(message.title()));
            notification.setMessage(message.body());
            notification.setLinkUrl(message.linkUrl());
            notificationRepository.save(notification);
        });
    }

    private static String truncate(String text) {
        return text.length() <= MAX_TITLE ? text : text.substring(0, MAX_TITLE - 1) + "…";
    }
}