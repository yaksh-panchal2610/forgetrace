package com.forgetrace.controller.web;

import com.forgetrace.service.ManufacturerDirectoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/** Public marketing pages. */
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final ManufacturerDirectoryService directoryService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("processes", directoryService.activeProcesses());
        model.addAttribute("featured", directoryService.featured(6));
        model.addAttribute("verifiedCount", directoryService.verifiedManufacturerCount());
        model.addAttribute("materialCount", directoryService.activeMaterials().size());
        return "public/index";
    }

    @GetMapping("/about")
    public String about() {
        return "public/about";
    }

    @GetMapping("/how-it-works")
    public String howItWorks() {
        return "public/how-it-works";
    }

    @GetMapping("/privacy")
    public String privacy() {
        return "public/privacy";
    }

    @GetMapping("/terms")
    public String terms() {
        return "public/terms";
    }
}