package com.forgetrace.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Who can open which URL.
 * Public pages are open to everyone; each portal is locked to its role.
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final LoginSuccessHandler loginSuccessHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                // Public website, login/register, static files, error pages, health check
                .requestMatchers(
                        "/", "/about", "/how-it-works", "/contact", "/privacy", "/terms",
                        "/manufacturers", "/manufacturers/**", "/p/**",
                        "/auth/**",
                        "/css/**", "/js/**", "/images/**", "/favicon.ico", "/favicon.svg",
                        "/error", "/error/**",
                        "/actuator/health", "/actuator/health/**"
                ).permitAll()
                // Each portal is locked to one role
                .requestMatchers("/buyer/**").hasRole("BUYER")
                .requestMatchers("/manufacturer/**").hasRole("MANUFACTURER")
                .requestMatchers("/inspector/**").hasRole("QUALITY_INSPECTOR")
                .requestMatchers("/admin/**", "/actuator/**").hasRole("ADMIN")
                // Everything else (e.g. /api/**, /notifications, /files/**) needs a login
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/auth/login")
                .loginProcessingUrl("/auth/login")
                .usernameParameter("email")
                .passwordParameter("password")
                .successHandler(loginSuccessHandler)
                .failureUrl("/auth/login?error")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/auth/logout")
                .logoutSuccessUrl("/auth/login?logout")
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .headers(headers -> headers.frameOptions(frame -> frame.deny()));
        // CSRF protection stays ON (default). Thymeleaf adds the token to every form automatically.

        return http.build();
    }
}