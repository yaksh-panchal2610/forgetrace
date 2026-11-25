package com.forgetrace.service;

import com.forgetrace.entity.Notification;
import com.forgetrace.entity.OrganizationMember;
import com.forgetrace.entity.User;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.notification.NotificationChannel;
import com.forgetrace.notification.NotificationMessage;
import com.forgetrace.repository.NotificationRepository;
import com.forgetrace.repository.OrganizationMemberRepository;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.security.ForgeTraceUserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

/** Sends notifications through every channel and lists them for the bell icon. */
@Service
@RequiredArgsConstructor
public class NotificationService {

    private static final int PAGE_SIZE = 20;

    /** Spring injects ALL NotificationChannel beans (in-app + email). */
    private final List<NotificationChannel> channels;
    private final NotificationRepository notificationRepository;
    private final OrganizationMemberRepository memberRepository;
    private final CurrentUserService currentUserService;

    // ---------- Sending ----------

    /** Delivers one message through every channel. Safe to call from background threads. */
    public void send(NotificationMessage message) {
        channels.forEach(channel -> channel.send(message));
    }

    /** One message per active member of the organization. */
    @Transactional(readOnly = true)
    public List<NotificationMessage> messagesForOrganization(Long organizationId, String title, String body, String link) {
        return memberRepository.findByOrganization_IdAndActiveTrue(organizationId).stream()
                .map(OrganizationMember::getUser)
                .map(user -> toMessage(user, title, body, link))
                .toList();
    }

    /** Notify everyone in an organization right now (used for single-recipient events). */
    @Transactional
    public void notifyOrganization(Long organizationId, String title, String body, String link) {
        messagesForOrganization(organizationId, title, body, link).forEach(this::send);
    }

    // ---------- Bell icon / notifications page ----------

    @Transactional(readOnly = true)
    public Page<Notification> myNotifications(int page) {
        Long userId = currentUserService.requireUserId();
        return notificationRepository.findByUser_IdOrderByCreatedAtDesc(userId, PageRequest.of(Math.max(page, 0), PAGE_SIZE));
    }

    @Transactional(readOnly = true)
    public long myUnreadCount() {
        Optional<ForgeTraceUserPrincipal> principal = currentUserService.findPrincipal();
        return principal.map(p -> notificationRepository.countByUser_IdAndReadAtIsNull(p.getId())).orElse(0L);
    }

    /** Marks one notification as read and returns where it should take the user. */
    @Transactional
    public String markReadAndGetLink(Long notificationId) {
        Long userId = currentUserService.requireUserId();
        Notification notification = notificationRepository.findById(notificationId)
                .filter(n -> n.getUser().getId().equals(userId)) // only your own notifications
                .orElseThrow(() -> new ResourceNotFoundException("Notification", notificationId));
        if (notification.getReadAt() == null) {
            notification.setReadAt(Instant.now());
        }
        return notification.getLinkUrl();
    }

    @Transactional
    public int markAllRead() {
        return notificationRepository.markAllRead(currentUserService.requireUserId(), Instant.now());
    }

    private static NotificationMessage toMessage(User user, String title, String body, String link) {
        return new NotificationMessage(user.getId(), user.getEmail(), user.getFullName(), title, body, link);
    }
}