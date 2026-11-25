package com.forgetrace.service;

import com.forgetrace.dto.request.OrganizationUpdateRequest;
import com.forgetrace.dto.request.ProfileUpdateRequest;
import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.User;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.OrganizationMapper;
import com.forgetrace.repository.ManufacturerProfileRepository;
import com.forgetrace.repository.ManufacturingProcessRepository;
import com.forgetrace.repository.MaterialRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;

/** Profile and company settings for the logged-in user's own organization. */
@Service
@RequiredArgsConstructor
public class OrganizationService {

    private final OrganizationRepository organizationRepository;
    private final ManufacturerProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final ManufacturingProcessRepository processRepository;
    private final MaterialRepository materialRepository;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final OrganizationMapper mapper;
    private final AuditService auditService;

    @Transactional(readOnly = true)
    public Organization getCurrentOrganization() {
        Long organizationId = currentUserService.requireOrganizationId();
        return organizationRepository.findById(organizationId)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", organizationId));
    }

    @Transactional(readOnly = true)
    public ProfileUpdateRequest currentProfileForm() {
        return mapper.toProfileForm(currentUser());
    }

    @Transactional(readOnly = true)
    public OrganizationUpdateRequest currentOrganizationForm() {
        Organization org = getCurrentOrganization();
        ManufacturerProfile profile = org.getOrganizationType() == OrganizationType.MANUFACTURER
                ? profileRepository.findById(org.getId()).orElse(null)
                : null;
        return mapper.toOrganizationForm(org, profile);
    }

    @Transactional
    public void updateCurrentUserProfile(ProfileUpdateRequest form) {
        User user = currentUser();
        mapper.applyToUser(form, user);
        auditService.record(user.getId(), "PROFILE_UPDATED", "User", user.getId(), null);
    }

    @Transactional
    public void updateCurrentOrganization(OrganizationUpdateRequest form) {
        Long organizationId = currentUserService.requireOrganizationId();
        accessGuard.requireMembership(organizationId);

        Organization org = organizationRepository.findById(organizationId)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", organizationId));
        mapper.applyToOrganization(form, org);

        if (org.getOrganizationType() == OrganizationType.MANUFACTURER) {
            if (form.getProcessIds() == null || form.getProcessIds().isEmpty()
                    || form.getMaterialIds() == null || form.getMaterialIds().isEmpty()) {
                throw new BusinessRuleException("Select at least one process and one material.");
            }
            List<ManufacturingProcess> processes = processRepository.findAllById(form.getProcessIds());
            List<Material> materials = materialRepository.findAllById(form.getMaterialIds());
            if (processes.size() != new HashSet<>(form.getProcessIds()).size()
                    || materials.size() != new HashSet<>(form.getMaterialIds()).size()) {
                throw new BusinessRuleException("Some selected processes or materials do not exist.");
            }
            ManufacturerProfile profile = profileRepository.findById(organizationId)
                    .orElseThrow(() -> new ResourceNotFoundException("Manufacturer profile", organizationId));
            mapper.applyToProfile(form, profile, processes, materials);
        }

        auditService.record(currentUserService.requireUserId(), "ORGANIZATION_UPDATED",
                "Organization", organizationId, null);
    }

    @Transactional(readOnly = true)
    public List<ManufacturingProcess> activeProcesses() {
        return processRepository.findByActiveTrueOrderByProcessNameAsc();
    }

    @Transactional(readOnly = true)
    public List<Material> activeMaterials() {
        return materialRepository.findByActiveTrueOrderByMaterialNameAsc();
    }

    private User currentUser() {
        Long userId = currentUserService.requireUserId();
        return userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", userId));
    }
}