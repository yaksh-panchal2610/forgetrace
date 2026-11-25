package com.forgetrace.service;

import com.forgetrace.entity.AuditLog;
import com.forgetrace.repository.AuditLogRepository;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/** Writes a permanent "who did what" record for important actions. */
@Service
@RequiredArgsConstructor
public class AuditService {

    private final AuditLogRepository auditLogRepository;
    private final UserRepository userRepository;

    @Transactional
    public void record(Long actorUserId, String action, String entityType, Long entityId, String details) {
        AuditLog entry = new AuditLog();
        if (actorUserId != null) {
            entry.setActorUser(userRepository.getReferenceById(actorUserId));
        }
        entry.setAction(action);
        entry.setEntityType(entityType);
        entry.setEntityId(entityId);
        entry.setDetails(details);
        entry.setIpAddress(currentIpAddress());
        auditLogRepository.save(entry);
    }

    private String currentIpAddress() {
        if (RequestContextHolder.getRequestAttributes() instanceof ServletRequestAttributes attributes) {
            return attributes.getRequest().getRemoteAddr();
        }
        return null; // e.g. called from a scheduled job, not a web request
    }
}