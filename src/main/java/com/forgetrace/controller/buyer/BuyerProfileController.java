package com.forgetrace.controller.buyer;

import com.forgetrace.dto.request.OrganizationUpdateRequest;
import com.forgetrace.dto.request.ProfileUpdateRequest;
import com.forgetrace.service.OrganizationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/buyer/profile")
@RequiredArgsConstructor
public class BuyerProfileController {

    private final OrganizationService organizationService;

    @GetMapping
    public String view(Model model) {
        model.addAttribute("profileForm", organizationService.currentProfileForm());
        model.addAttribute("orgForm", organizationService.currentOrganizationForm());
        model.addAttribute("organization", organizationService.getCurrentOrganization());
        return "buyer/profile";
    }

    @PostMapping
    public String updatePersonal(@Valid @ModelAttribute("profileForm") ProfileUpdateRequest form,
                                 BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("orgForm", organizationService.currentOrganizationForm());
            model.addAttribute("organization", organizationService.getCurrentOrganization());
            return "buyer/profile";
        }
        organizationService.updateCurrentUserProfile(form);
        redirect.addFlashAttribute("success", "Your details were saved.");
        return "redirect:/buyer/profile";
    }

    @PostMapping("/organization")
    public String updateOrganization(@Valid @ModelAttribute("orgForm") OrganizationUpdateRequest form,
                                     BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("profileForm", organizationService.currentProfileForm());
            model.addAttribute("organization", organizationService.getCurrentOrganization());
            return "buyer/profile";
        }
        organizationService.updateCurrentOrganization(form);
        redirect.addFlashAttribute("success", "Company details were saved.");
        return "redirect:/buyer/profile";
    }
}