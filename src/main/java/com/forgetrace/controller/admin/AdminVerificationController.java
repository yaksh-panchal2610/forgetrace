package com.forgetrace.controller.admin;

import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.ManufacturerVerificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/verifications")
@RequiredArgsConstructor
public class AdminVerificationController {

    private final ManufacturerVerificationService verificationService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("pending", verificationService.pending());
        return "admin/verifications";
    }

    @PostMapping("/{id}/approve")
    public String approve(@PathVariable Long id, @RequestParam(required = false) String note, RedirectAttributes redirect) {
        try {
            redirect.addFlashAttribute("success", verificationService.approve(id, note).getDisplayName() + " is now verified.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/verifications";
    }

    @PostMapping("/{id}/reject")
    public String reject(@PathVariable Long id, @RequestParam(required = false) String reason, RedirectAttributes redirect) {
        try {
            redirect.addFlashAttribute("info", verificationService.reject(id, reason).getDisplayName() + " was rejected.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/verifications";
    }

    @PostMapping("/{id}/reopen")
    public String reopen(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            redirect.addFlashAttribute("success", verificationService.reopen(id).getDisplayName() + " is back in the review queue.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/verifications";
    }
}