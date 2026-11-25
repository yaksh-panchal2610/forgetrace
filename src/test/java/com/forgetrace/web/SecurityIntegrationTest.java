package com.forgetrace.web;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.UUID;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@ActiveProfiles("dev")
class SecurityIntegrationTest {

    @Autowired
    private WebApplicationContext context;

    private MockMvc mvc;

    @BeforeEach
    void setUp() {
        mvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
    }

    @Test
    void publicPagesAreOpen() throws Exception {
        mvc.perform(get("/")).andExpect(status().isOk());
        mvc.perform(get("/auth/login")).andExpect(status().isOk());
        mvc.perform(get("/actuator/health")).andExpect(status().isOk());
    }

    @Test
    void privateAreaRedirectsToLogin() throws Exception {
        mvc.perform(get("/buyer/dashboard"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/auth/login"));
    }

    @Test
    @WithMockUser(roles = "MANUFACTURER")
    void manufacturerCannotOpenInspectorQueue() throws Exception {
        mvc.perform(get("/inspector/queue")).andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "BUYER")
    void buyerCannotOpenAdminArea() throws Exception {
        mvc.perform(get("/admin/dashboard")).andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "BUYER")
    void postWithoutCsrfTokenIsRejected() throws Exception {
        mvc.perform(post("/buyer/orders").param("quotationId", "1")).andExpect(status().isForbidden());
    }

    @Test
    void unknownPassportReturns404() throws Exception {
        mvc.perform(get("/p/" + UUID.randomUUID())).andExpect(status().isNotFound());
        mvc.perform(get("/p/not-a-uuid")).andExpect(status().isNotFound());
    }
}