package com.forgetrace.controller.admin;

import com.forgetrace.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminOperationsController {

    private final AdminService adminService;

    @GetMapping("/rfqs")
    public String rfqs(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.rfqs(page));
        return "admin/rfqs";
    }

    @GetMapping("/orders")
    public String orders(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.orders(page));
        return "admin/orders";
    }

    @GetMapping("/machines")
    public String machines(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.machines(page));
        return "admin/machines";
    }

    @GetMapping("/batches")
    public String batches(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.batches(page));
        return "admin/batches";
    }

    @GetMapping("/payments")
    public String payments(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", adminService.payments(page));
        return "admin/payments";
    }
}