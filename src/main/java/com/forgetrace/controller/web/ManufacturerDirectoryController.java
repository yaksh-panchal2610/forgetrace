package com.forgetrace.controller.web;

import com.forgetrace.dto.request.ManufacturerSearchCriteria;
import com.forgetrace.service.ManufacturerDirectoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manufacturers")
@RequiredArgsConstructor
public class ManufacturerDirectoryController {

    private final ManufacturerDirectoryService directoryService;

    @GetMapping
    public String list(@Valid @ModelAttribute("criteria") ManufacturerSearchCriteria criteria,
                       BindingResult bindingResult, Model model) {
        // Bad filter values (e.g. ?processId=abc) are ignored instead of failing the page
        ManufacturerSearchCriteria filters = bindingResult.hasErrors() ? new ManufacturerSearchCriteria() : criteria;
        model.addAttribute("results", directoryService.search(filters));
        model.addAttribute("processes", directoryService.activeProcesses());
        model.addAttribute("materials", directoryService.activeMaterials());
        return "public/manufacturers";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("m", directoryService.getDetail(id));
        return "public/manufacturer-detail";
    }
}