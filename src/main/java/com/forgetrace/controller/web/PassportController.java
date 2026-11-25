package com.forgetrace.controller.web;

import com.forgetrace.dto.response.PassportView;
import com.forgetrace.service.PassportService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/p")
@RequiredArgsConstructor
public class PassportController {

    private final PassportService passportService;

    @GetMapping("/{token}")
    public String view(@PathVariable String token, Model model, HttpServletResponse response) {
        UUID uuid = parse(token);
        Optional<PassportView> passport = uuid == null ? Optional.empty() : passportService.publicView(uuid);
        if (passport.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return "public/passport-not-found";
        }
        model.addAttribute("p", passport.get());
        model.addAttribute("passportUrl", passportService.publicUrl(uuid));
        return "public/passport";
    }

    @GetMapping("/{token}/qr.png")
    public ResponseEntity<byte[]> qr(@PathVariable String token) {
        UUID uuid = parse(token);
        if (uuid == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .cacheControl(CacheControl.maxAge(1, TimeUnit.DAYS))
                .body(passportService.qrPng(uuid));
    }

    private static UUID parse(String token) {
        try {
            return UUID.fromString(token);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }
}