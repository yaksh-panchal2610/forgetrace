package com.forgetrace.dto.request;

import com.forgetrace.enums.OrderStatus;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderStatusUpdateRequest {

    @NotNull(message = "Choose the new status")
    private OrderStatus status;

    @Size(max = 500)
    private String notes;
}