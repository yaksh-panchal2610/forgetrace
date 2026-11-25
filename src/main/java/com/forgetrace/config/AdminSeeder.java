package com.forgetrace.config;

import com.forgetrace.entity.Organization;
import com.forgetrace.entity.OrganizationMember;
import com.forgetrace.entity.Role;
import com.forgetrace.entity.User;
import com.forgetrace.enums.MembershipRole;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.RoleName;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.repository.OrganizationMemberRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.RoleRepository;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;

/**
 * Runs once at startup. Creates the platform organization, the first admin
 * and a demo quality inspector - only if they do not exist yet.
 * Emails and passwords come from configuration / environment variables, never from code.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AdminSeeder implements ApplicationRunner {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final OrganizationRepository organizationRepository;
    private final OrganizationMemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${app.admin.name:Platform Admin}")
    private String adminName;
    @Value("${app.admin.email:}")
    private String adminEmail;
    @Value("${app.admin.password:}")
    private String adminPassword;

    @Value("${app.inspector.name:Quality Inspector}")
    private String inspectorName;
    @Value("${app.inspector.email:}")
    private String inspectorEmail;
    @Value("${app.inspector.password:}")
    private String inspectorPassword;

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        Organization platform = findOrCreatePlatformOrganization();
        seedUser(adminName, adminEmail, adminPassword, RoleName.ADMIN, platform);
        seedUser(inspectorName, inspectorEmail, inspectorPassword, RoleName.QUALITY_INSPECTOR, platform);
    }

    private Organization findOrCreatePlatformOrganization() {
        return organizationRepository
                .findByOrganizationTypeAndVerificationStatus(OrganizationType.PLATFORM, VerificationStatus.VERIFIED)
                .stream()
                .findFirst()
                .orElseGet(() -> {
                    Organization org = new Organization();
                    org.setLegalName("ForgeTrace Platform");
                    org.setDisplayName("ForgeTrace");
                    org.setOrganizationType(OrganizationType.PLATFORM);
                    org.setVerificationStatus(VerificationStatus.VERIFIED);
                    log.info("Created platform organization");
                    return organizationRepository.save(org);
                });
    }

    private void seedUser(String name, String email, String password, RoleName roleName, Organization platform) {
        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            log.warn("No {} account configured (set app.{}.email and password) - skipping",
                    roleName, roleName == RoleName.ADMIN ? "admin" : "inspector");
            return;
        }
        String normalized = email.trim().toLowerCase(Locale.ROOT);
        if (userRepository.existsByEmailIgnoreCase(normalized)) {
            return; // already created on an earlier start
        }

        Role role = roleRepository.findByRoleName(roleName)
                .orElseThrow(() -> new IllegalStateException("Role " + roleName + " missing"));

        User user = new User();
        user.setFullName(name);
        user.setEmail(normalized);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setEmailVerified(true);
        user.getRoles().add(role);
        userRepository.save(user);

        OrganizationMember member = new OrganizationMember();
        member.setOrganization(platform);
        member.setUser(user);
        member.setMembershipRole(roleName == RoleName.ADMIN ? MembershipRole.OWNER : MembershipRole.MEMBER);
        memberRepository.save(member);

        log.info("Created {} account: {}", roleName, normalized);
    }
}