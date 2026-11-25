package com.forgetrace.controller.web;

import com.forgetrace.dto.request.ContactForm;
import com.forgetrace.service.ContactService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contact")
@RequiredArgsConstructor
public class ContactController {

    private final ContactService contactService;

    @GetMapping
    public String form(Model model) {
        model.addAttribute("form", new ContactForm());
        return "public/contact";
    }

    @PostMapping
    public String submit(@Valid @ModelAttribute("form") ContactForm form, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "public/contact";
        }
        contactService.submit(form);
        return "redirect:/contact?sent";
    }
}