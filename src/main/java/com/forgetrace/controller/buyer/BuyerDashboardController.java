package com.forgetrace.controller.buyer;

import com.forgetrace.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/buyer")
@RequiredArgsConstructor
public class BuyerDashboardController {

    private final DashboardService dashboardService;

    @GetMapping({"", "/dashboard"})
    public String dashboard(Model model) {
        model.addAttribute("dash", dashboardService.buyerDashboard());
        return "buyer/dashboard";
    }
}