package com.forgetrace.config;

import com.forgetrace.enums.RoleName;
import com.forgetrace.security.ForgeTraceUserPrincipal;
import com.forgetrace.service.AuditService;
import com.forgetrace.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

/** After a successful login: record it, then send each role to its own dashboard. */
@Component
@RequiredArgsConstructor
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;
    private final AuditService auditService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        String target = "/";
        if (authentication.getPrincipal() instanceof ForgeTraceUserPrincipal principal) {
            userService.recordSuccessfulLogin(principal.getId());
            auditService.record(principal.getId(), "LOGIN", "User", principal.getId(), null);
            target = dashboardFor(principal);
        }
        response.sendRedirect(request.getContextPath() + target);
    }

    static String dashboardFor(ForgeTraceUserPrincipal principal) {
        if (principal.hasRole(RoleName.ADMIN)) {
            return "/admin/dashboard";
        }
        if (principal.hasRole(RoleName.QUALITY_INSPECTOR)) {
            return "/inspector/dashboard";
        }
        if (principal.hasRole(RoleName.MANUFACTURER)) {
            return "/manufacturer/dashboard";
        }
        if (principal.hasRole(RoleName.BUYER)) {
            return "/buyer/dashboard";
        }
        return "/";
    }
}