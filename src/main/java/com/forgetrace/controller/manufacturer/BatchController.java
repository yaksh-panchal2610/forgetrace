package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.BatchCreateRequest;
import com.forgetrace.entity.Batch;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.BatchService;
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
@RequestMapping("/manufacturer/batches")
@RequiredArgsConstructor
public class BatchController {

    private final BatchService batchService;

    @GetMapping
    public String list(@RequestParam(required = false) Long orderId, Model model) {
        model.addAttribute("batches", batchService.listMine(orderId));
        model.addAttribute("orderId", orderId);
        return "manufacturer/batch-list";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Long orderId, Model model) {
        BatchCreateRequest form = new BatchCreateRequest();
        form.setOrderId(orderId);
        model.addAttribute("form", form);
        model.addAttribute("orders", batchService.batchableOrders());
        return "manufacturer/batch-form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("form") BatchCreateRequest form, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                Batch batch = batchService.create(form);
                redirect.addFlashAttribute("success", "Batch " + batch.getBatchNumber() + " created.");
                return "redirect:/manufacturer/batches?orderId=" + form.getOrderId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("orders", batchService.batchableOrders());
        return "manufacturer/batch-form";
    }

    @PostMapping("/{id}/status")
    public String advance(@PathVariable Long id, @RequestParam BatchStatus status,
                          @RequestParam(required = false) Long orderId, RedirectAttributes redirect) {
        try {
            batchService.advance(id, status);
            redirect.addFlashAttribute("success", "Batch moved to '" + status.getLabel() + "'.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/batches" + (orderId == null ? "" : "?orderId=" + orderId);
    }
}