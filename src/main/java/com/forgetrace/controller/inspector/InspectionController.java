package com.forgetrace.controller.inspector;

import com.forgetrace.dto.request.InspectionRequest;
import com.forgetrace.dto.request.MeasurementRequest;
import com.forgetrace.enums.InspectionStatus;
import com.forgetrace.enums.InspectionType;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.BatchService;
import com.forgetrace.service.InspectionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/inspector")
@RequiredArgsConstructor
public class InspectionController {

    private static final List<InspectionStatus> DECISIONS =
            List.of(InspectionStatus.PASSED, InspectionStatus.FAILED, InspectionStatus.ON_HOLD);

    private final InspectionService inspectionService;
    private final BatchService batchService;

    @GetMapping("/queue")
    public String queue(Model model) {
        model.addAttribute("batches", batchService.inspectionQueue());
        return "inspector/queue";
    }

    @GetMapping("/batches/{id}")
    public String batch(@PathVariable Long id, Model model) {
        model.addAttribute("batch", inspectionService.batch(id));
        model.addAttribute("rfq", inspectionService.requirementsForBatch(id));
        model.addAttribute("inspections", inspectionService.inspectionsForBatch(id));
        return "inspector/batch-detail";
    }

    @GetMapping("/batches/{id}/inspect")
    public String form(@PathVariable Long id, Model model) {
        InspectionRequest form = new InspectionRequest();
        for (int i = 0; i < 3; i++) {
            form.getMeasurements().add(new MeasurementRequest());
        }
        model.addAttribute("form", form);
        addFormData(id, model);
        return "inspector/inspection-form";
    }

    @PostMapping("/batches/{id}/inspect")
    public String submit(@PathVariable Long id, @Valid @ModelAttribute("form") InspectionRequest form,
                         BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                inspectionService.submit(id, form);
                redirect.addFlashAttribute("success", "Inspection recorded: " + form.getDecision().getLabel() + ".");
                return "redirect:/inspector/batches/" + id;
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        addFormData(id, model);
        return "inspector/inspection-form";
    }

    @GetMapping("/inspections/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("inspection", inspectionService.detail(id));
        return "inspector/inspection-detail";
    }

    @GetMapping("/history")
    public String history(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", inspectionService.myHistory(page));
        return "inspector/history";
    }

    private void addFormData(Long batchId, Model model) {
        model.addAttribute("batch", inspectionService.batch(batchId));
        model.addAttribute("rfq", inspectionService.requirementsForBatch(batchId));
        model.addAttribute("types", InspectionType.values());
        model.addAttribute("decisions", DECISIONS);
    }
}