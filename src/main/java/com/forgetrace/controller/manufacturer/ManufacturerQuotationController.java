package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.QuotationCreateRequest;
import com.forgetrace.dto.response.QuotationComparisonRow;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.QuotationService;
import com.forgetrace.service.RfqService;
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
@RequestMapping("/manufacturer")
@RequiredArgsConstructor
public class ManufacturerQuotationController {

    private final QuotationService quotationService;
    private final RfqService rfqService;

    @GetMapping("/quotations")
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", quotationService.myQuotations(page));
        return "manufacturer/quotation-list";
    }

    @GetMapping("/rfqs/{rfqId}/quote")
    public String form(@PathVariable Long rfqId, Model model) {
        model.addAttribute("form", quotationService.newForm(rfqId));
        model.addAttribute("rfq", rfqService.detailForManufacturer(rfqId));
        return "manufacturer/quotation-form";
    }

    @PostMapping("/rfqs/{rfqId}/quote")
    public String submit(@PathVariable Long rfqId, @Valid @ModelAttribute("form") QuotationCreateRequest form,
                         BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                QuotationComparisonRow row = quotationService.submit(rfqId, form);
                redirect.addFlashAttribute("success", "Quotation " + row.quotationNumber()
                        + (row.versionNumber() > 1 ? " (version " + row.versionNumber() + ")" : "")
                        + " sent to the buyer.");
                return "redirect:/manufacturer/rfqs/" + rfqId;
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("rfq", rfqService.detailForManufacturer(rfqId));
        return "manufacturer/quotation-form";
    }

    @PostMapping("/quotations/{id}/withdraw")
    public String withdraw(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            quotationService.withdraw(id);
            redirect.addFlashAttribute("success", "Quotation withdrawn.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/quotations";
    }
}