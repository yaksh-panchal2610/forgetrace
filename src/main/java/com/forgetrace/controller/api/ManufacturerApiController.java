package com.forgetrace.controller.api;

import com.forgetrace.dto.request.ManufacturerSearchCriteria;
import com.forgetrace.dto.response.ManufacturerCard;
import com.forgetrace.dto.response.ManufacturerDetailView;
import com.forgetrace.service.ManufacturerDirectoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/manufacturers")
@RequiredArgsConstructor
public class ManufacturerApiController {

    private final ManufacturerDirectoryService directoryService;

    @GetMapping
    public List<ManufacturerCard> search(@Valid ManufacturerSearchCriteria criteria) {
        return directoryService.search(criteria);
    }

    @GetMapping("/{id}")
    public ManufacturerDetailView detail(@PathVariable Long id) {
        return directoryService.getDetail(id);
    }
}