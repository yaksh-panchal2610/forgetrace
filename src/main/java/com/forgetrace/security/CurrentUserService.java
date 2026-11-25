package com.forgetrace.security;

import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.UnauthorizedOperationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CurrentUserService {

    public Optional<ForgeTraceUserPrincipal> findPrincipal() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof ForgeTraceUserPrincipal principal) {
            return Optional.of(principal);
        }
        return Optional.empty();
    }

    public ForgeTraceUserPrincipal requirePrincipal() {
        return findPrincipal()
                .orElseThrow(() -> new UnauthorizedOperationException("You must be signed in."));
    }

    public Long requireUserId() {
        return requirePrincipal().getId();
    }

    public Long requireOrganizationId() {
        Long organizationId = requirePrincipal().getOrganizationId();
        if (organizationId == null) {
            throw new UnauthorizedOperationException("Your account is not linked to an organization.");
        }
        return organizationId;
    }

    public boolean hasRole(RoleName role) {
        return findPrincipal().map(p -> p.hasRole(role)).orElse(false);
    }
}