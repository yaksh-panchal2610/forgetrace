package com.forgetrace.controller.admin;

import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.report.ReportFormat;
import com.forgetrace.report.ReportJob;
import com.forgetrace.report.ReportType;
import com.forgetrace.service.AdminService;
import com.forgetrace.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AdminReportController {

    private final ReportService reportService;
    private final AdminService adminService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    @GetMapping("/admin/reports")
    public String reports(Model model) {
        LocalDate today = LocalDate.now(ZoneId.of(displayZone));
        List<ReportJob> jobs = reportService.recentJobs();
        model.addAttribute("jobs", jobs);
        model.addAttribute("running", jobs.stream().anyMatch(j -> !j.isFinished()));
        model.addAttribute("files", reportService.files());
        model.addAttribute("types", ReportType.values());
        model.addAttribute("formats", ReportFormat.values());
        model.addAttribute("defaultFrom", today.minusDays(30));
        model.addAttribute("defaultTo", today);
        return "admin/reports";
    }

    @PostMapping("/admin/reports")
    public String request(@RequestParam ReportType type, @RequestParam ReportFormat format,
                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
                          RedirectAttributes redirect) {
        try {
            reportService.request(type, format, from, to);
            redirect.addFlashAttribute("success", type.getLabel() + " report is being generated in the background.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/admin/reports";
    }

    @PostMapping("/admin/reports/audit-export")
    public String exportAudit(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
                              RedirectAttributes redirect) {
        try {
            redirect.addFlashAttribute("success", "Audit log saved as " + reportService.exportAuditLog(from, to) + ".");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        } catch (IOException ex) {
            redirect.addFlashAttribute("error", "Could not write the export file: " + ex.getMessage());
        }
        return "redirect:/admin/reports";
    }

    @GetMapping("/admin/reports/download")
    public ResponseEntity<Resource> download(@RequestParam String name) {
        Path file = reportService.resolveDownload(name);
        MediaType type = name.endsWith(".pdf") ? MediaType.APPLICATION_PDF : MediaType.parseMediaType("text/csv");
        return ResponseEntity.ok()
                .contentType(type)
                .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment().filename(name).build().toString())
                .body(new FileSystemResource(file));
    }

    @GetMapping("/admin/audit-logs")
    public String auditLogs(@RequestParam(defaultValue = "0") int page, Model model) {
        LocalDate today = LocalDate.now(ZoneId.of(displayZone));
        model.addAttribute("page", adminService.auditLogs(page));
        model.addAttribute("defaultFrom", today.minusDays(30));
        model.addAttribute("defaultTo", today);
        return "admin/audit-logs";
    }
}