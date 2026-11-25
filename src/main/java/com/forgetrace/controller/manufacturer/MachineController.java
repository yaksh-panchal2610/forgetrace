package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.MachineRequest;
import com.forgetrace.dto.response.CsvImportResult;
import com.forgetrace.enums.MachineStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.MachineService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/manufacturer/machines")
@RequiredArgsConstructor
public class MachineController {

    private final MachineService machineService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("machines", machineService.listMine());
        model.addAttribute("statuses", MachineStatus.values());
        return "manufacturer/machine-list";
    }

    // ---------- Create ----------

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("form", new MachineRequest());
        model.addAttribute("machineId", null);
        addFormData(model);
        return "manufacturer/machine-form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("form") MachineRequest form, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                machineService.create(form);
                redirect.addFlashAttribute("success", "Machine '" + form.getMachineName() + "' was added.");
                return "redirect:/manufacturer/machines";
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("machineId", null);
        addFormData(model);
        return "manufacturer/machine-form";
    }

    // ---------- Edit ----------

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) {
        model.addAttribute("form", machineService.editForm(id));
        model.addAttribute("machineId", id);
        addFormData(model);
        return "manufacturer/machine-form";
    }

    @PostMapping("/{id}")
    public String update(@PathVariable Long id, @Valid @ModelAttribute("form") MachineRequest form,
                         BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                machineService.update(id, form);
                redirect.addFlashAttribute("success", "Machine '" + form.getMachineName() + "' was updated.");
                return "redirect:/manufacturer/machines";
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("machineId", id);
        addFormData(model);
        return "manufacturer/machine-form";
    }

    @PostMapping("/{id}/status")
    public String changeStatus(@PathVariable Long id, @RequestParam MachineStatus status, RedirectAttributes redirect) {
        machineService.changeStatus(id, status);
        redirect.addFlashAttribute("success", "Machine status changed to '" + status.getLabel() + "'.");
        return "redirect:/manufacturer/machines";
    }

    // ---------- CSV import / export ----------

    @GetMapping("/import")
    public String importPage(Model model) {
        addFormData(model);
        return "manufacturer/machine-import";
    }

    @PostMapping("/import")
    public String importCsv(@RequestParam("file") MultipartFile file, Model model) {
        try {
            CsvImportResult result = machineService.importCsv(file);
            model.addAttribute("result", result);
        } catch (BusinessRuleException ex) {
            model.addAttribute("error", ex.getMessage());
        }
        addFormData(model);
        return "manufacturer/machine-import";
    }

    @GetMapping("/import/template")
    public ResponseEntity<Resource> downloadTemplate() {
        Resource template = new ClassPathResource("sample-data/machines-sample.csv");
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType("text/csv"))
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        ContentDisposition.attachment().filename("forgetrace-machines-template.csv").build().toString())
                .body(template);
    }

    @GetMapping("/export")
    public void export(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION,
                ContentDisposition.attachment().filename("forgetrace-machines.csv").build().toString());
        PrintWriter writer = response.getWriter();
        writer.write('\uFEFF'); // lets Excel detect UTF-8
        machineService.exportMine(writer);
    }

    private void addFormData(Model model) {
        MachineService.Capabilities capabilities = machineService.capabilities();
        model.addAttribute("processes", capabilities.processes());
        model.addAttribute("materials", capabilities.materials());
        model.addAttribute("statuses", MachineStatus.values());
    }
}