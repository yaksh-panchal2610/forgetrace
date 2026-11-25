package com.forgetrace.controller.buyer;

import com.forgetrace.dto.request.DisputeRequest;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.DisputeService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/buyer/disputes")
@RequiredArgsConstructor
public class BuyerDisputeController {

    private final DisputeService disputeService;

    @GetMapping
    public String list(@RequestParam(required = false) Long orderId, @RequestParam(defaultValue = "0") int page, Model model) {
        DisputeRequest form = new DisputeRequest();
        form.setOrderId(orderId);
        model.addAttribute("form", form);
        addData(page, model);
        return "buyer/disputes";
    }

    @PostMapping
    public String open(@Valid @ModelAttribute("form") DisputeRequest form, BindingResult bindingResult,
                       Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                disputeService.open(form);
                redirect.addFlashAttribute("success", "Dispute opened. The ForgeTrace team will review it.");
                return "redirect:/buyer/disputes";
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        addData(0, model);
        return "buyer/disputes";
    }

    private void addData(int page, Model model) {
        model.addAttribute("orders", disputeService.orderOptions());
        model.addAttribute("page", disputeService.listForBuyer(page));
    }
}