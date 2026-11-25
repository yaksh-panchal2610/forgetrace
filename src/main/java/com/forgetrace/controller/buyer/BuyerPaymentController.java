package com.forgetrace.controller.buyer;

import com.forgetrace.dto.request.PaymentRequest;
import com.forgetrace.dto.response.PaymentResult;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.qr.QrCodeGenerator;
import com.forgetrace.service.PaymentService;
import com.forgetrace.service.ShipmentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class BuyerPaymentController {

    private final PaymentService paymentService;
    private final ShipmentService shipmentService;
    private final QrCodeGenerator qrCodeGenerator;

    @Value("${forgetrace.payment.upi-payee:forgetrace.sandbox@okbank}")
    private String upiPayee;

    @GetMapping("/buyer/orders/{id}/pay")
    public String checkout(@PathVariable Long id, Model model) {
        PaymentService.CheckoutView checkout = paymentService.checkout(id);
        PaymentRequest form = new PaymentRequest();
        form.setIdempotencyKey(checkout.idempotencyKey());
        model.addAttribute("checkout", checkout);
        model.addAttribute("form", form);
        model.addAttribute("methods", PaymentService.CUSTOMER_METHODS);
        model.addAttribute("upiPayee", upiPayee);
        return "buyer/payment-checkout";
    }

    @GetMapping("/buyer/orders/{id}/upi-qr.png")
    public ResponseEntity<byte[]> upiQr(@PathVariable Long id) {
        PaymentService.CheckoutView checkout = paymentService.checkout(id);
        if (!checkout.payable()) {
            return ResponseEntity.notFound().build();
        }
        String amount = checkout.amount().setScale(2, RoundingMode.HALF_UP).toPlainString();
        String reference = checkout.orderNumber() + "-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String link = "upi://pay?pa=" + enc(upiPayee)
                + "&pn=" + enc("ForgeTrace")
                + "&am=" + amount
                + "&cu=" + enc(checkout.currency())
                + "&tn=" + enc("Payment for " + checkout.orderNumber())
                + "&tr=" + enc(reference);
        return ResponseEntity.ok()
                .cacheControl(CacheControl.noStore())
                .contentType(MediaType.IMAGE_PNG)
                .body(qrCodeGenerator.png(link, 280));
    }

    @PostMapping("/buyer/orders/{id}/pay")
    public String pay(@PathVariable Long id, @Valid @ModelAttribute("form") PaymentRequest form,
                      BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("checkout", paymentService.checkout(id));
            model.addAttribute("methods", PaymentService.CUSTOMER_METHODS);
            model.addAttribute("upiPayee", upiPayee);
            return "buyer/payment-checkout";
        }
        try {
            PaymentResult result = paymentService.pay(id, form);
            if (result.replayed()) {
                redirect.addFlashAttribute("info", "This payment request was already processed (" + result.reference()
                        + ", " + result.status().getLabel() + "). You were not charged again.");
                return result.isSucceeded() ? "redirect:/buyer/orders/" + id + "/tracking" : "redirect:/buyer/orders/" + id + "/pay";
            }
            if (result.isSucceeded()) {
                redirect.addFlashAttribute("success", "Payment successful. Reference " + result.reference() + ".");
                return "redirect:/buyer/orders/" + id + "/tracking";
            }
            redirect.addFlashAttribute("error", "Payment failed: " + result.failureReason() + " You were not charged.");
            return "redirect:/buyer/orders/" + id + "/pay";
        } catch (BusinessRuleException ex) {
            redirect.addFlashAttribute("error", ex.getMessage());
            return "redirect:/buyer/orders/" + id + "/pay";
        }
    }

    @GetMapping("/buyer/orders/{id}/tracking")
    public String tracking(@PathVariable Long id, Model model) {
        model.addAttribute("t", shipmentService.tracking(id));
        model.addAttribute("payments", paymentService.forOrder(id));
        return "buyer/order-tracking";
    }

    @GetMapping("/buyer/payments")
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("page", paymentService.listForBuyer(page));
        return "buyer/payments";
    }

    private static String enc(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8).replace("+", "%20");
    }
}