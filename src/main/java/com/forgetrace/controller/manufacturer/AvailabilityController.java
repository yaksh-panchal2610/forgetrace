package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.AvailabilityRuleRequest;
import com.forgetrace.dto.request.MaintenanceBlockRequest;
import com.forgetrace.entity.Machine;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.AvailabilityService;
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
@RequestMapping("/manufacturer/availability")
@RequiredArgsConstructor
public class AvailabilityController {

    static final List<String> DAY_NAMES = List.of(
            "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");

    private final AvailabilityService availabilityService;

    @GetMapping
    public String page(@RequestParam(required = false) Long machineId, Model model) {
        AvailabilityRuleRequest ruleForm = new AvailabilityRuleRequest();
        MaintenanceBlockRequest blockForm = new MaintenanceBlockRequest();
        populate(model, machineId, ruleForm, blockForm);
        return "manufacturer/availability";
    }

    @PostMapping("/rules")
    public String addRules(@Valid @ModelAttribute("ruleForm") AvailabilityRuleRequest ruleForm,
                           BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                int added = availabilityService.addRules(ruleForm);
                redirect.addFlashAttribute("success", "Working hours added for " + added + " day(s).");
                return "redirect:/manufacturer/availability?machineId=" + ruleForm.getMachineId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        populate(model, ruleForm.getMachineId(), ruleForm, new MaintenanceBlockRequest());
        return "manufacturer/availability";
    }

    @PostMapping("/rules/{ruleId}/delete")
    public String deleteRule(@PathVariable Long ruleId, @RequestParam Long machineId, RedirectAttributes redirect) {
        availabilityService.deleteRule(ruleId);
        redirect.addFlashAttribute("success", "Working-hours rule removed.");
        return "redirect:/manufacturer/availability?machineId=" + machineId;
    }

    @PostMapping("/maintenance")
    public String addMaintenance(@Valid @ModelAttribute("blockForm") MaintenanceBlockRequest blockForm,
                                 BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                availabilityService.addMaintenance(blockForm);
                redirect.addFlashAttribute("success", "Maintenance period added.");
                return "redirect:/manufacturer/availability?machineId=" + blockForm.getMachineId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        populate(model, blockForm.getMachineId(), new AvailabilityRuleRequest(), blockForm);
        return "manufacturer/availability";
    }

    @PostMapping("/maintenance/{blockId}/delete")
    public String deleteMaintenance(@PathVariable Long blockId, @RequestParam Long machineId, RedirectAttributes redirect) {
        availabilityService.deleteMaintenance(blockId);
        redirect.addFlashAttribute("success", "Maintenance period removed.");
        return "redirect:/manufacturer/availability?machineId=" + machineId;
    }

    /** Puts everything the page needs into the model. Selects the first machine if none is chosen. */
    private void populate(Model model, Long machineId,
                          AvailabilityRuleRequest ruleForm, MaintenanceBlockRequest blockForm) {
        List<Machine> machines = availabilityService.myMachines();
        model.addAttribute("machines", machines);
        model.addAttribute("dayNames", DAY_NAMES);

        Long selectedId = machineId;
        if (selectedId == null && !machines.isEmpty()) {
            selectedId = machines.get(0).getId();
        }
        model.addAttribute("selectedMachineId", selectedId);

        if (selectedId != null) {
            ruleForm.setMachineId(selectedId);
            blockForm.setMachineId(selectedId);
            model.addAttribute("rules", availabilityService.rules(selectedId));
            model.addAttribute("blocks", availabilityService.maintenanceBlocks(selectedId));
        }
        model.addAttribute("ruleForm", ruleForm);
        model.addAttribute("blockForm", blockForm);
    }
}