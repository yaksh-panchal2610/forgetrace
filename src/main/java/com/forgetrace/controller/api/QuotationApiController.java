package com.forgetrace.controller.api;

import com.forgetrace.dto.request.QuotationCreateRequest;
import com.forgetrace.dto.response.QuotationComparisonRow;
import com.forgetrace.service.QuotationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/rfqs/{rfqId}/quotations")
@RequiredArgsConstructor
public class QuotationApiController {

    private final QuotationService quotationService;

    /** Buyer: comparison of all quotations on my RFQ. */
    @GetMapping
    public List<QuotationComparisonRow> compare(@PathVariable Long rfqId) {
        return quotationService.compareForRfq(rfqId);
    }

    /** Manufacturer: submit a quotation (JSON body). Needs the X-CSRF-TOKEN header. */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public QuotationComparisonRow submit(@PathVariable Long rfqId, @Valid @RequestBody QuotationCreateRequest request) {
        return quotationService.submit(rfqId, request);
    }
}