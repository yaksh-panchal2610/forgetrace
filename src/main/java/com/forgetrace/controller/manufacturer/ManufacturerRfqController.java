package com.forgetrace.controller.manufacturer;

import com.forgetrace.service.QuotationService;
import com.forgetrace.service.RfqService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manufacturer/rfqs")
@RequiredArgsConstructor
public class ManufacturerRfqController {

    private final RfqService rfqService;
    private final QuotationService quotationService;

    @GetMapping
    public String inbox(Model model) {
        model.addAttribute("verified", rfqService.currentManufacturerVerified());
        model.addAttribute("rfqs", rfqService.inbox());
        return "manufacturer/rfq-inbox";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("rfq", rfqService.detailForManufacturer(id));
        model.addAttribute("myQuotations", quotationService.myQuotationsForRfq(id));
        model.addAttribute("verified", rfqService.currentManufacturerVerified());
        return "manufacturer/rfq-detail";
    }
}