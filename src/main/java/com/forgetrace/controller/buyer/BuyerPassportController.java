package com.forgetrace.controller.buyer;

import com.forgetrace.service.BatchService;
import com.forgetrace.storage.RecallService;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class BuyerPassportController {

    private final BatchService batchService;
    private final RecallService recallService;

    @GetMapping("/buyer/passports")
    public String list(Model model) {
        model.addAttribute("batches", batchService.passportsForBuyer());
        model.addAttribute("recalls", recallService.noticesForBuyer());
        return "buyer/passports";
    }

    @PostMapping("/buyer/recalls/{id}/acknowledge")
    public String acknowledge(@PathVariable Long id, RedirectAttributes redirect) {
        recallService.acknowledge(id);
        redirect.addFlashAttribute("success", "Recall notice acknowledged.");
        return "redirect:/buyer/passports";
    }
}