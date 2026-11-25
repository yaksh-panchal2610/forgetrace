package com.forgetrace.dto.request;

import com.forgetrace.enums.PaymentMethod;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PaymentRequest {

    @NotNull(message = "Choose a payment method")
    private PaymentMethod method = PaymentMethod.CARD;

    @NotBlank(message = "Reload the page and try again")
    @Size(max = 80)
    private String idempotencyKey;

    @Size(max = 23)
    private String cardNumber;

    @Size(max = 100)
    private String upiId;
}