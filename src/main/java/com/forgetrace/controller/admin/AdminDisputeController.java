package com.forgetrace.controller.admin;

import com.forgetrace.enums.DisputeStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.DisputeService;
import com.forgetrace.service.ReviewService;
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
public class AdminDisputeController {

    private final DisputeService disputeService;
    private final ReviewService reviewService;

    @GetMapping("/admin/disputes")
    public String list(@RequestParam(required = false) DisputeStatus status,
                       @RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", disputeService.listAll(status, page));
        model.addAttribute("status", status);
        model.addAttribute("statuses", DisputeStatus.values());
        return "admin/disputes";
    }

    @GetMapping("/admin/disputes/{id}")
    public String detail(@PathVariable Long id, Model model) {
        DisputeService.DisputeView dispute = disputeService.detail(id);
        model.addAttribute("d", dispute);
        model.addAttribute("nextStatuses", DisputeService.nextStatuses(dispute.status()));
        return "admin/dispute-detail";
    }

    @PostMapping("/admin/disputes/{id}/status")
    public String update(@PathVariable Long id, @RequestParam DisputeStatus status,
                         @RequestParam(required = false) String resolution, RedirectAttributes redirect) {
        try {
            disputeService.update(id, status, resolution);
            redirect.addFlashAttribute("success", "Dispute is now '" + status.getLabel() + "'. Both parties were notified.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/disputes/" + id;
    }

    @GetMapping("/admin/reviews")
    public String reviews(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", reviewService.listAll(page));
        return "admin/reviews";
    }

    @PostMapping("/admin/reviews/{id}/delete")
    public String deleteReview(@PathVariable Long id, RedirectAttributes redirect) {
        reviewService.delete(id);
        redirect.addFlashAttribute("success", "Review removed. The action is in the audit log.");
        return "redirect:/admin/reviews";
    }
}