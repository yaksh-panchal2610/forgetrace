package com.forgetrace.controller.admin;

import com.forgetrace.dto.request.RecallRequest;
import com.forgetrace.entity.Recall;
import com.forgetrace.enums.RecallSeverity;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.storage.RecallService;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/recalls")
@RequiredArgsConstructor
public class AdminRecallController {

    private final RecallService recallService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", recallService.list(page));
        return "admin/recalls";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Long batchId, Model model, RedirectAttributes redirect) {
        if (batchId == null) {
            redirect.addFlashAttribute("info", "Choose the batch to recall from this list.");
            return "redirect:/admin/batches";
        }
        try {
            model.addAttribute("batch", recallService.batchForRecall(batchId));
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
            return "redirect:/admin/batches";
        }
        RecallRequest form = new RecallRequest();
        form.setBatchId(batchId);
        model.addAttribute("form", form);
        model.addAttribute("severities", RecallSeverity.values());
        return "admin/recall-form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("form") RecallRequest form, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                Recall recall = recallService.initiate(form);
                redirect.addFlashAttribute("success", "Recall issued. The buyer and manufacturer were notified.");
                return "redirect:/admin/recalls/" + recall.getId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("batch", recallService.batchForRecall(form.getBatchId()));
        model.addAttribute("severities", RecallSeverity.values());
        return "admin/recall-form";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("r", recallService.detail(id));
        return "admin/recall-detail";
    }

    @PostMapping("/{id}/close")
    public String close(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            recallService.close(id);
            redirect.addFlashAttribute("success", "Recall closed.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/recalls/" + id;
    }
}