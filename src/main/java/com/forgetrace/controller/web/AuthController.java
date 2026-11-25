package com.forgetrace.controller.web;

import com.forgetrace.dto.request.ForgotPasswordRequest;
import com.forgetrace.dto.request.RegisterBuyerRequest;
import com.forgetrace.dto.request.RegisterManufacturerRequest;
import com.forgetrace.dto.request.ResetPasswordRequest;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.DuplicateEmailException;
import com.forgetrace.exception.InvalidTokenException;
import com.forgetrace.service.AuthService;
import com.forgetrace.service.PasswordResetService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Login, registration and password reset pages.
 * The actual login POST is handled by Spring Security (see SecurityConfig).
 */
@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final PasswordResetService passwordResetService;

    // ---------- Login ----------

    @GetMapping("/login")
    public String login(Authentication authentication) {
        if (isLoggedIn(authentication)) {
            return "redirect:/";
        }
        return "auth/login";
    }

    // ---------- Registration ----------

    @GetMapping("/register")
    public String chooseAccountType() {
        return "auth/register";
    }

    @GetMapping("/register/buyer")
    public String buyerForm(Model model) {
        model.addAttribute("form", new RegisterBuyerRequest());
        return "auth/register-buyer";
    }

    @PostMapping("/register/buyer")
    public String registerBuyer(@Valid @ModelAttribute("form") RegisterBuyerRequest form,
                                BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "auth/register-buyer";
        }
        try {
            authService.registerBuyer(form);
        } catch (DuplicateEmailException ex) {
            bindingResult.rejectValue("email", "duplicate", ex.getMessage());
            return "auth/register-buyer";
        }
        return "redirect:/auth/login?registered=buyer";
    }

    @GetMapping("/register/manufacturer")
    public String manufacturerForm(Model model) {
        model.addAttribute("form", new RegisterManufacturerRequest());
        addReferenceData(model);
        return "auth/register-manufacturer";
    }

    @PostMapping("/register/manufacturer")
    public String registerManufacturer(@Valid @ModelAttribute("form") RegisterManufacturerRequest form,
                                       BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            addReferenceData(model);
            return "auth/register-manufacturer";
        }
        try {
            authService.registerManufacturer(form);
        } catch (DuplicateEmailException ex) {
            bindingResult.rejectValue("email", "duplicate", ex.getMessage());
            addReferenceData(model);
            return "auth/register-manufacturer";
        } catch (BusinessRuleException ex) {
            bindingResult.reject("invalid", ex.getMessage());
            addReferenceData(model);
            return "auth/register-manufacturer";
        }
        return "redirect:/auth/login?registered=manufacturer";
    }

    // ---------- Forgot / reset password ----------

    @GetMapping("/forgot-password")
    public String forgotPasswordForm(Model model) {
        model.addAttribute("form", new ForgotPasswordRequest());
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@Valid @ModelAttribute("form") ForgotPasswordRequest form,
                                 BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "auth/forgot-password";
        }
        passwordResetService.requestReset(form.getEmail());
        // Same message whether or not the email exists
        return "redirect:/auth/forgot-password?sent";
    }

    @GetMapping("/reset-password")
    public String resetPasswordForm(@RequestParam(name = "token", required = false) String token, Model model) {
        ResetPasswordRequest form = new ResetPasswordRequest();
        form.setToken(token);
        model.addAttribute("form", form);
        model.addAttribute("tokenValid", passwordResetService.isTokenValid(token));
        return "auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@Valid @ModelAttribute("form") ResetPasswordRequest form,
                                BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("tokenValid", true);
            return "auth/reset-password";
        }
        try {
            passwordResetService.resetPassword(form.getToken(), form.getPassword());
        } catch (InvalidTokenException ex) {
            model.addAttribute("tokenValid", false);
            return "auth/reset-password";
        }
        return "redirect:/auth/login?reset";
    }

    // ---------- helpers ----------

    private void addReferenceData(Model model) {
        model.addAttribute("processes", authService.activeProcesses());
        model.addAttribute("materials", authService.activeMaterials());
    }

    private static boolean isLoggedIn(Authentication authentication) {
        return authentication != null
                && authentication.isAuthenticated()
                && !(authentication instanceof AnonymousAuthenticationToken);
    }
}