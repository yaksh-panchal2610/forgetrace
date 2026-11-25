package com.forgetrace.controller.manufacturer;

import com.forgetrace.dto.request.BookingRequest;
import com.forgetrace.dto.request.OrderStatusUpdateRequest;
import com.forgetrace.dto.response.OrderView;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.BookingService;
import com.forgetrace.service.OrderService;
import com.forgetrace.service.ProductionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
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

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;

@Controller
@RequestMapping("/manufacturer/orders")
@RequiredArgsConstructor
public class ManufacturerOrderController {

    private final OrderService orderService;
    private final ProductionService productionService;
    private final BookingService bookingService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", orderService.listForManufacturer(page));
        return "manufacturer/order-list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        OrderView order = orderService.getForManufacturer(id);
        model.addAttribute("order", order);
        model.addAttribute("timeline", productionService.timeline(id));
        model.addAttribute("reservations", bookingService.reservationsForOrder(id));
        model.addAttribute("machines", bookingService.machinesForOrder(id));
        model.addAttribute("nextStatuses", productionService.nextStatusesForManufacturer(order));

        // Default booking: tomorrow 09:00 - 17:00 (Indian time)
        BookingRequest bookingForm = new BookingRequest();
        bookingForm.setOrderId(id);
        LocalDate tomorrow = LocalDate.now(ZoneId.of(displayZone)).plusDays(1);
        bookingForm.setStartAt(tomorrow.atTime(LocalTime.of(9, 0)));
        bookingForm.setEndAt(tomorrow.atTime(LocalTime.of(17, 0)));
        model.addAttribute("bookingForm", bookingForm);
        model.addAttribute("statusForm", new OrderStatusUpdateRequest());
        return "manufacturer/order-detail";
    }

    @PostMapping("/{id}/status")
    public String changeStatus(@PathVariable Long id, @Valid @ModelAttribute("statusForm") OrderStatusUpdateRequest form,
                               BindingResult bindingResult, RedirectAttributes redirect) {
        if (bindingResult.hasErrors()) {
            redirect.addFlashAttribute("error", "Choose the new status.");
            return "redirect:/manufacturer/orders/" + id;
        }
        try {
            productionService.changeStatusAsManufacturer(id, form.getStatus(), form.getNotes());
            redirect.addFlashAttribute("success", "Order status changed to '" + form.getStatus().getLabel() + "'.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/orders/" + id;
    }

    @PostMapping("/{id}/bookings")
    public String book(@PathVariable Long id, @Valid @ModelAttribute("bookingForm") BookingRequest form,
                       BindingResult bindingResult, RedirectAttributes redirect) {
        form.setOrderId(id);
        if (bindingResult.hasErrors()) {
            redirect.addFlashAttribute("error", bindingResult.getAllErrors().get(0).getDefaultMessage());
            return "redirect:/manufacturer/orders/" + id;
        }
        try {
            BookingService.ReservationView booking = bookingService.book(form);
            redirect.addFlashAttribute("success", "Machine '" + booking.machineName() + "' reserved.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/orders/" + id;
    }

    @PostMapping("/{id}/bookings/{reservationId}/cancel")
    public String cancelBooking(@PathVariable Long id, @PathVariable Long reservationId, RedirectAttributes redirect) {
        try {
            bookingService.cancel(reservationId);
            redirect.addFlashAttribute("success", "Booking cancelled - the machine time is free again.");
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/manufacturer/orders/" + id;
    }
}