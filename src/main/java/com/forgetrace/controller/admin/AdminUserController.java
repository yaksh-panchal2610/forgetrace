package com.forgetrace.controller.admin;

import com.forgetrace.enums.AccountStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class AdminUserController {

    private final AdminService adminService;

    @GetMapping("/admin/users")
    public String users(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.users(page));
        return "admin/users";
    }

    @PostMapping("/admin/users/{id}/status")
    public String setStatus(@PathVariable Long id, @RequestParam AccountStatus status,
                            @RequestParam(defaultValue = "0") int page, RedirectAttributes redirect) {
        try {
            adminService.setUserStatus(id, status);
            redirect.addFlashAttribute("success", "User is now " + status.getLabel().toLowerCase() + ".");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/users?page=" + page;
    }

    @GetMapping("/admin/organizations")
    public String organizations(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.organizations(page));
        return "admin/organizations";
    }
}