package com.forgetrace.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addRedirectViewController("/favicon.ico", "/images/favicon.svg");
        registry.addRedirectViewController("/login", "/auth/login");
        registry.addRedirectViewController("/manufacturer", "/manufacturer/dashboard");
    }
}