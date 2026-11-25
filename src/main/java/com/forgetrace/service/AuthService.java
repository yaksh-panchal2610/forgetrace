package com.forgetrace.service;

import com.forgetrace.dto.request.RegisterBuyerRequest;
import com.forgetrace.dto.request.RegisterManufacturerRequest;
import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.OrganizationMember;
import com.forgetrace.entity.Role;
import com.forgetrace.entity.User;
import com.forgetrace.enums.MembershipRole;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.RoleName;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.DuplicateEmailException;
import com.forgetrace.repository.ManufacturerProfileRepository;
import com.forgetrace.repository.ManufacturingProcessRepository;
import com.forgetrace.repository.MaterialRepository;
import com.forgetrace.repository.OrganizationMemberRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.RoleRepository;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Locale;

/**
 * Registration of buyers and manufacturers.
 * Each registration creates: User + Organization + OrganizationMember (+ ManufacturerProfile)
 * inside ONE transaction - either everything is saved or nothing is.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final OrganizationRepository organizationRepository;
    private final OrganizationMemberRepository memberRepository;
    private final ManufacturerProfileRepository profileRepository;
    private final ManufacturingProcessRepository processRepository;
    private final MaterialRepository materialRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuditService auditService;

    @Transactional
    public User registerBuyer(RegisterBuyerRequest request) {
        String email = normalizeEmail(request.getEmail());
        ensureEmailIsFree(email);

        User user = createUser(request.getFullName(), email, request.getPhone(), request.getPassword(), RoleName.BUYER);

        Organization organization = new Organization();
        organization.setLegalName(request.getCompanyName().trim());
        organization.setDisplayName(request.getCompanyName().trim());
        organization.setOrganizationType(OrganizationType.BUYER);
        organization.setEmail(email);
        organization.setPhone(blankToNull(request.getPhone()));
        organization.setCity(blankToNull(request.getCity()));
        organization.setState(blankToNull(request.getState()));
        // MVP decision: buyers can start immediately; manufacturers need admin verification
        organization.setVerificationStatus(VerificationStatus.VERIFIED);
        organizationRepository.save(organization);

        addOwner(organization, user);

        auditService.record(user.getId(), "REGISTER_BUYER", "Organization", organization.getId(), organization.getDisplayName());
        log.info("New buyer registered: user={} organization={}", user.getId(), organization.getId());
        return user;
    }

    @Transactional
    public User registerManufacturer(RegisterManufacturerRequest request) {
        String email = normalizeEmail(request.getEmail());
        ensureEmailIsFree(email);

        List<ManufacturingProcess> processes = processRepository.findAllById(request.getProcessIds());
        List<Material> materials = materialRepository.findAllById(request.getMaterialIds());
        if (processes.size() != new HashSet<>(request.getProcessIds()).size()
                || materials.size() != new HashSet<>(request.getMaterialIds()).size()) {
            throw new BusinessRuleException("Some selected processes or materials do not exist.");
        }

        User user = createUser(request.getFullName(), email, request.getPhone(), request.getPassword(), RoleName.MANUFACTURER);

        Organization organization = new Organization();
        organization.setLegalName(request.getCompanyName().trim());
        organization.setDisplayName(request.getCompanyName().trim());
        organization.setOrganizationType(OrganizationType.MANUFACTURER);
        organization.setRegistrationNumber(blankToNull(request.getRegistrationNumber()));
        organization.setTaxId(blankToNull(request.getTaxId()));
        organization.setEmail(email);
        organization.setPhone(blankToNull(request.getPhone()));
        organization.setCity(blankToNull(request.getCity()));
        organization.setState(blankToNull(request.getState()));
        organization.setVerificationStatus(VerificationStatus.PENDING); // admin must verify
        organizationRepository.save(organization);

        ManufacturerProfile profile = new ManufacturerProfile();
        profile.setOrganization(organization);
        profile.setDescription(blankToNull(request.getDescription()));
        profile.setYearsInOperation(request.getYearsInOperation());
        profile.getProcesses().addAll(processes);
        profile.getMaterials().addAll(materials);
        profileRepository.save(profile);

        addOwner(organization, user);

        auditService.record(user.getId(), "REGISTER_MANUFACTURER", "Organization", organization.getId(), organization.getDisplayName());
        log.info("New manufacturer registered (pending verification): user={} organization={}", user.getId(), organization.getId());
        return user;
    }

    @Transactional(readOnly = true)
    public List<ManufacturingProcess> activeProcesses() {
        return processRepository.findByActiveTrueOrderByProcessNameAsc();
    }

    @Transactional(readOnly = true)
    public List<Material> activeMaterials() {
        return materialRepository.findByActiveTrueOrderByMaterialNameAsc();
    }

    // ---------- helpers ----------

    private User createUser(String fullName, String email, String phone, String rawPassword, RoleName roleName) {
        Role role = roleRepository.findByRoleName(roleName)
                .orElseThrow(() -> new IllegalStateException("Role " + roleName + " is missing - check V8 seed migration"));

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email);
        user.setPhone(blankToNull(phone));
        user.setPasswordHash(passwordEncoder.encode(rawPassword)); // BCrypt - never store plain passwords
        user.getRoles().add(role);

        try {
            return userRepository.saveAndFlush(user);
        } catch (DataIntegrityViolationException ex) {
            // Two people registering the same email at the same moment
            throw new DuplicateEmailException();
        }
    }

    private void addOwner(Organization organization, User user) {
        OrganizationMember member = new OrganizationMember();
        member.setOrganization(organization);
        member.setUser(user);
        member.setMembershipRole(MembershipRole.OWNER);
        memberRepository.save(member);
    }

    private void ensureEmailIsFree(String email) {
        if (userRepository.existsByEmailIgnoreCase(email)) {
            throw new DuplicateEmailException();
        }
    }

    static String normalizeEmail(String email) {
        return email == null ? null : email.trim().toLowerCase(Locale.ROOT);
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}