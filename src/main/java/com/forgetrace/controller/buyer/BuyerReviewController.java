package com.forgetrace.controller.buyer;

import com.forgetrace.dto.request.ReviewRequest;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.ReviewService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/buyer/orders/{id}/review")
@RequiredArgsConstructor
public class BuyerReviewController {

    private final ReviewService reviewService;

    @GetMapping
    public String form(@PathVariable Long id, Model model, RedirectAttributes redirect) {
        try {
            model.addAttribute("target", reviewService.target(id));
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
            return "redirect:/buyer/orders/" + id;
        }
        model.addAttribute("form", new ReviewRequest());
        return "buyer/review-form";
    }

    @PostMapping
    public String submit(@PathVariable Long id, @Valid @ModelAttribute("form") ReviewRequest form,
                         BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        try {
            if (!bindingResult.hasErrors()) {
                reviewService.submit(id, form);
                redirect.addFlashAttribute("success", "Thank you! Your review is published.");
                return "redirect:/buyer/orders/" + id;
            }
            model.addAttribute("target", reviewService.target(id));
            return "buyer/review-form";
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
            return "redirect:/buyer/orders/" + id;
        }
    }
}