package com.forgetrace.config;

import com.forgetrace.enums.RoleName;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.security.ForgeTraceUserPrincipal;
import com.forgetrace.service.NotificationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice(basePackages = {
        "com.forgetrace.controller.web",
        "com.forgetrace.controller.buyer",
        "com.forgetrace.controller.manufacturer",
        "com.forgetrace.controller.inspector",
        "com.forgetrace.controller.admin"
})
@RequiredArgsConstructor
public class GlobalModelAttributes {

    private final CurrentUserService currentUserService;
    private final NotificationService notificationService;

    @ModelAttribute("currentPath")
    public String currentPath(HttpServletRequest request) {
        return request.getRequestURI();
    }

    @ModelAttribute("currentUser")
    public ForgeTraceUserPrincipal currentUser() {
        return currentUserService.findPrincipal().orElse(null);
    }

    @ModelAttribute("navRole")
    public String navRole() {
        return currentUserService.findPrincipal().map(p -> {
            if (p.hasRole(RoleName.ADMIN)) return "ADMIN";
            if (p.hasRole(RoleName.QUALITY_INSPECTOR)) return "INSPECTOR";
            if (p.hasRole(RoleName.MANUFACTURER)) return "MANUFACTURER";
            if (p.hasRole(RoleName.BUYER)) return "BUYER";
            return null;
        }).orElse(null);
    }

    @ModelAttribute("dashboardUrl")
    public String dashboardUrl() {
        return currentUserService.findPrincipal()
                .map(LoginSuccessHandler::dashboardFor)
                .orElse(null);
    }

    /** Number on the bell icon. 0 for visitors. */
    @ModelAttribute("unreadNotifications")
    public long unreadNotifications() {
        return notificationService.myUnreadCount();
    }
}