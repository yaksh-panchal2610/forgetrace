package com.forgetrace.controller.api;

import com.forgetrace.dto.response.RfqDetailView;
import com.forgetrace.dto.response.RfqSummary;
import com.forgetrace.enums.RoleName;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.service.RfqService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * JSON API for RFQs (Postman / integration tests).
 * Same services and the same permission checks as the web pages.
 */
@RestController
@RequestMapping("/api/rfqs")
@RequiredArgsConstructor
public class RfqApiController {

    private final RfqService rfqService;
    private final CurrentUserService currentUserService;

    /** Buyer: my RFQs (one page). */
    @GetMapping
    public List<RfqSummary> mine(@RequestParam(defaultValue = "0") int page) {
        return rfqService.listMine(page).getContent();
    }

    /** Manufacturer: open RFQs that match my capabilities. */
    @GetMapping("/inbox")
    public List<RfqSummary> inbox() {
        return rfqService.inbox();
    }

    @GetMapping("/{id}")
    public RfqDetailView detail(@PathVariable Long id) {
        return currentUserService.hasRole(RoleName.MANUFACTURER)
                ? rfqService.detailForManufacturer(id)
                : rfqService.detailForBuyer(id);
    }
}