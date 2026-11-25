package com.forgetrace.controller.buyer;

import com.forgetrace.dto.response.QuotationComparisonRow;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.QuotationService;
import com.forgetrace.service.RfqService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/** Accepting a quotation is a POST to /buyer/orders - see BuyerOrderController (Step 7). */
@Controller
@RequestMapping("/buyer/quotations")
@RequiredArgsConstructor
public class BuyerQuotationController {

    private final QuotationService quotationService;
    private final RfqService rfqService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", quotationService.buyerQuotations(page));
        return "buyer/quotation-list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        QuotationComparisonRow quotation = quotationService.detailForBuyer(id);
        model.addAttribute("q", quotation);
        model.addAttribute("rfq", rfqService.detailForBuyer(quotation.rfqId()));
        return "buyer/quotation-detail";
    }

    @PostMapping("/{id}/reject")
    public String reject(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            quotationService.reject(id);
            redirect.addFlashAttribute("success", "Quotation declined. The manufacturer has been informed.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/buyer/quotations/" + id;
    }
}