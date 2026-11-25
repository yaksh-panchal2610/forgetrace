package com.forgetrace.controller.buyer;

import com.forgetrace.dto.response.OrderView;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.service.BookingService;
import com.forgetrace.service.OrderService;
import com.forgetrace.service.ProductionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/buyer/orders")
@RequiredArgsConstructor
public class BuyerOrderController {

    private final OrderService orderService;
    private final ProductionService productionService;
    private final BookingService bookingService;

    /** "Accept" button on a quotation posts here. */
    @PostMapping
    public String acceptQuotation(@RequestParam Long quotationId, RedirectAttributes redirect) {
        try {
            ProductionOrder order = orderService.acceptQuotation(quotationId);
            redirect.addFlashAttribute("success", "Quotation accepted. Order " + order.getOrderNumber()
                    + " has been created and the manufacturer notified.");
            return "redirect:/buyer/orders/" + order.getId();
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
            return "redirect:/buyer/quotations/" + quotationId;
        }
    }

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", orderService.listForBuyer(page));
        return "buyer/order-list";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        OrderView order = orderService.getForBuyer(id);
        model.addAttribute("order", order);
        model.addAttribute("timeline", productionService.timeline(id));
        model.addAttribute("reservations", bookingService.reservationsForOrder(id));
        model.addAttribute("canCancel", order.status() == OrderStatus.CONFIRMED);
        model.addAttribute("canComplete", order.status() == OrderStatus.DELIVERED);
        return "buyer/order-detail";
    }

    @PostMapping("/{id}/cancel")
    public String cancel(@PathVariable Long id, @RequestParam(required = false) String notes, RedirectAttributes redirect) {
        return changeStatus(id, OrderStatus.CANCELLED, notes, "Order cancelled.", redirect);
    }

    @PostMapping("/{id}/complete")
    public String complete(@PathVariable Long id, RedirectAttributes redirect) {
        return changeStatus(id, OrderStatus.COMPLETED, "Buyer confirmed the order is complete", "Order marked as completed.", redirect);
    }

    private String changeStatus(Long id, OrderStatus status, String notes, String message, RedirectAttributes redirect) {
        try {
            productionService.changeStatusAsBuyer(id, status, notes);
            redirect.addFlashAttribute("success", message);
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/buyer/orders/" + id;
    }
}