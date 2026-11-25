package com.forgetrace.controller.admin;

import com.forgetrace.enums.ContactStatus;
import com.forgetrace.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminSettingsController {

    private final AdminService adminService;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;
    @Value("${app.storage.mode:local}")
    private String storageMode;
    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;
    @Value("${app.export-dir:exports}")
    private String exportDir;
    @Value("${app.mail.log-emails:false}")
    private boolean logEmails;
    @Value("${spring.profiles.active:default}")
    private String profile;

    @GetMapping("/admin/settings")
    public String settings(@RequestParam(defaultValue = "0") int page, Model model) {
        Map<String, String> config = new LinkedHashMap<>();
        config.put("Active profile", profile);
        config.put("Public base URL (used in QR codes)", baseUrl);
        config.put("File storage", storageMode);
        config.put("Display time zone", displayZone);
        config.put("Report export folder", exportDir);
        config.put("Emails", logEmails ? "Logged to console (dev)" : "Sent by mail server");
        model.addAttribute("config", config);
        model.addAttribute("page", adminService.contacts(page));
        model.addAttribute("contactStatuses", ContactStatus.values());
        return "admin/settings";
    }

    @PostMapping("/admin/contacts/{id}/status")
    public String contactStatus(@PathVariable Long id, @RequestParam ContactStatus status, RedirectAttributes redirect) {
        adminService.setContactStatus(id, status);
        redirect.addFlashAttribute("success", "Contact request marked '" + status.getLabel() + "'.");
        return "redirect:/admin/settings";
    }
}