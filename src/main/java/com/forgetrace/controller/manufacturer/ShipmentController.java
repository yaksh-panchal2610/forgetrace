package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.ShipmentEventRequest;
import com.forgetrace.dto.request.ShipmentRequest;
import com.forgetrace.entity.Shipment;
import com.forgetrace.enums.ShipmentStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.ShipmentService;
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
@RequestMapping("/manufacturer/shipments")
@RequiredArgsConstructor
public class ShipmentController {

    private static final List<ShipmentStatus> EVENT_STATUSES = List.of(ShipmentStatus.IN_TRANSIT, ShipmentStatus.DELIVERED);

    private final ShipmentService shipmentService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", shipmentService.listMine(page));
        return "manufacturer/shipment-list";
    }

    @GetMapping("/new")
    public String form(@RequestParam(required = false) Long orderId, Model model) {
        ShipmentRequest form = new ShipmentRequest();
        form.setOrderId(orderId);
        model.addAttribute("form", form);
        model.addAttribute("orders", shipmentService.readyOrders());
        return "manufacturer/shipment-form";
    }

    @PostMapping
    public String create(@Valid @ModelAttribute("form") ShipmentRequest form, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect) {
        if (!bindingResult.hasErrors()) {
            try {
                Shipment shipment = shipmentService.create(form);
                redirect.addFlashAttribute("success", "Shipment dispatched. The buyer has been notified.");
                return "redirect:/manufacturer/shipments/" + shipment.getId();
            } catch (BusinessRuleException ex) {
                bindingResult.reject("rule", ex.getMessage());
            }
        }
        model.addAttribute("orders", shipmentService.readyOrders());
        return "manufacturer/shipment-form";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("s", shipmentService.detail(id));
        model.addAttribute("eventForm", new ShipmentEventRequest());
        model.addAttribute("eventStatuses", EVENT_STATUSES);
        return "manufacturer/shipment-detail";
    }

    @PostMapping("/{id}/events")
    public String addEvent(@PathVariable Long id, @Valid @ModelAttribute("eventForm") ShipmentEventRequest form,
                           BindingResult bindingResult, RedirectAttributes redirect) {
        if (bindingResult.hasErrors()) {
            redirect.addFlashAttribute("error", "Check the status, location and remarks.");
            return "redirect:/manufacturer/shipments/" + id;
        }
        try {
            shipmentService.addEvent(id, form);
            redirect.addFlashAttribute("success", "Shipment updated: " + form.getStatus().getLabel() + ".");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/shipments/" + id;
    }
}