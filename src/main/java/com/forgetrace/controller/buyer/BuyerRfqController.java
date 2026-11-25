package com.forgetrace.controller.buyer;

import com.forgetrace.dto.request.RfqCreateRequest;
import com.forgetrace.entity.Rfq;
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
@RequestMapping("/buyer/rfqs")
@RequiredArgsConstructor
public class BuyerRfqController {

    private final RfqService rfqService;
    private final QuotationService quotationService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", rfqService.listMine(page));
        return "buyer/rfq-list";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("form", rfqService.newForm());
        addReferenceData(model);
        return "buyer/rfq-new";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("form") RfqCreateRequest form, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                Rfq rfq = rfqService.create(form);
                redirect.addFlashAttribute("success", "RFQ " + rfq.getRfqNumber()
                        + " posted. Matching verified manufacturers are being notified.");
                return "redirect:/buyer/rfqs/" + rfq.getId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        addReferenceData(model);
        return "buyer/rfq-new";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("rfq", rfqService.detailForBuyer(id));
        model.addAttribute("quotations", quotationService.compareForRfq(id));
        return "buyer/rfq-detail";
    }

    @PostMapping("/{id}/cancel")
    public String cancel(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            rfqService.cancel(id);
            redirect.addFlashAttribute("success", "RFQ cancelled. Manufacturers who quoted have been informed.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/buyer/rfqs/" + id;
    }

    private void addReferenceData(Model model) {
        model.addAttribute("processes", rfqService.activeProcesses());
        model.addAttribute("materials", rfqService.activeMaterials());
    }
}