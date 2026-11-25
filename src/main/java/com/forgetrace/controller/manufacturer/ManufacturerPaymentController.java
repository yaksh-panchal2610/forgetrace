package com.forgetrace.controller.manufacturer;

import com.forgetrace.service.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/manufacturer/payments")
@RequiredArgsConstructor
public class ManufacturerPaymentController {

    private final PaymentService paymentService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", paymentService.listForManufacturer(page));
        return "manufacturer/payments";
    }
}