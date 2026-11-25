package com.forgetrace.service;

import com.forgetrace.entity.Organization;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.RoleName;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ManufacturerVerificationService {

    private final OrganizationRepository organizationRepository;
    private final NotificationService notificationService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    @Transactional(readOnly = true)
    public List<Organization> pending() {
        accessGuard.requireRole(RoleName.ADMIN);
        return organizationRepository.findByOrganizationTypeAndVerificationStatus(
                OrganizationType.MANUFACTURER, VerificationStatus.PENDING);
    }

    @Transactional
    public Organization approve(Long organizationId, String note) {
        Organization org = loadManufacturer(organizationId, VerificationStatus.PENDING);
        org.setVerificationStatus(VerificationStatus.VERIFIED);
        notificationService.notifyOrganization(org.getId(), "Your company is verified",
                "You can now receive matching RFQs and send quotations." + (blank(note) ? "" : " Note: " + note.trim()),
                "/manufacturer/dashboard");
        auditService.record(currentUserService.requireUserId(), "MANUFACTURER_VERIFIED", "Organization", org.getId(),
                blank(note) ? null : note.trim());
        return org;
    }

    @Transactional
    public Organization reject(Long organizationId, String reason) {
        if (blank(reason)) {
            throw new BusinessRuleException("Give a reason so the manufacturer knows what to fix.");
        }
        Organization org = loadManufacturer(organizationId, VerificationStatus.PENDING);
        org.setVerificationStatus(VerificationStatus.REJECTED);
        notificationService.notifyOrganization(org.getId(), "Verification not approved",
                "Reason: " + reason.trim() + ". Update your company profile and contact support to apply again.",
                "/manufacturer/profile");
        auditService.record(currentUserService.requireUserId(), "MANUFACTURER_REJECTED", "Organization", org.getId(), reason.trim());
        return org;
    }

    @Transactional
    public Organization reopen(Long organizationId) {
        Organization org = loadManufacturer(organizationId, VerificationStatus.REJECTED);
        org.setVerificationStatus(VerificationStatus.PENDING);
        auditService.record(currentUserService.requireUserId(), "MANUFACTURER_REOPENED", "Organization", org.getId(), null);
        return org;
    }

    private Organization loadManufacturer(Long organizationId, VerificationStatus expected) {
        accessGuard.requireRole(RoleName.ADMIN);
        Organization org = organizationRepository.findById(organizationId)
                .filter(o -> o.getOrganizationType() == OrganizationType.MANUFACTURER)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", organizationId));
        if (org.getVerificationStatus() != expected) {
            throw new BusinessRuleException(org.getDisplayName() + " is '" + org.getVerificationStatus().getLabel()
                    + "', so this action is not available.");
        }
        return org;
    }

    private static boolean blank(String s) {
        return s == null || s.isBlank();
    }
}