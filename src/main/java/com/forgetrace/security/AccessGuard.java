package com.forgetrace.security;

import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.UnauthorizedOperationException;
import com.forgetrace.repository.OrganizationMemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@RequiredArgsConstructor
public class AccessGuard {

    private final CurrentUserService currentUserService;
    private final OrganizationMemberRepository memberRepository;

    public boolean isAdmin() {
        return currentUserService.hasRole(RoleName.ADMIN);
    }

    public void requireRole(RoleName... allowedRoles) {
        ForgeTraceUserPrincipal principal = currentUserService.requirePrincipal();
        boolean allowed = Arrays.stream(allowedRoles).anyMatch(principal::hasRole);
        if (!allowed) {
            throw new UnauthorizedOperationException("Your role is not allowed to do this.");
        }
    }

    public void requireMembership(Long organizationId) {
        if (isAdmin()) {
            return;
        }
        Long userId = currentUserService.requireUserId();
        boolean member = organizationId != null
                && memberRepository.existsByOrganization_IdAndUser_IdAndActiveTrue(organizationId, userId);
        if (!member) {
            throw new UnauthorizedOperationException("You do not have access to this organization's data.");
        }
    }

    public boolean isMemberOfAny(Long... organizationIds) {
        if (isAdmin()) {
            return true;
        }
        Long current = currentUserService.findPrincipal()
                .map(ForgeTraceUserPrincipal::getOrganizationId)
                .orElse(null);
        return current != null && Arrays.asList(organizationIds).contains(current);
    }
}