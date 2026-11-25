package com.forgetrace.controller.inspector;

import com.forgetrace.service.InspectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/inspector")
@RequiredArgsConstructor
public class InspectorDashboardController {

    private final InspectionService inspectionService;

    @GetMapping({"", "/dashboard"})
    public String dashboard(Model model) {
        model.addAttribute("dash", inspectionService.dashboard());
        return "inspector/dashboard";
    }

    @GetMapping("/reports")
    public String reports(Model model) {
        model.addAttribute("dash", inspectionService.dashboard());
        return "inspector/reports";
    }
}