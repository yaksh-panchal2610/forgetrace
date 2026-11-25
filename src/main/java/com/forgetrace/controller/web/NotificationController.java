package com.forgetrace.controller.web;

import com.forgetrace.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", notificationService.myNotifications(page));
        return "common/notifications";
    }

    /** Marks the notification as read, then goes to the page it refers to. */
    @GetMapping("/{id}/open")
    public String open(@PathVariable Long id) {
        String link = notificationService.markReadAndGetLink(id);
        // Only follow internal links (starting with a single "/") - blocks open-redirect attacks
        if (link != null && link.startsWith("/") && !link.startsWith("//")) {
            return "redirect:" + link;
        }
        return "redirect:/notifications";
    }

    @PostMapping("/read-all")
    public String markAllRead(RedirectAttributes redirect) {
        int count = notificationService.markAllRead();
        redirect.addFlashAttribute("success", count + " notification(s) marked as read.");
        return "redirect:/notifications";
    }
}