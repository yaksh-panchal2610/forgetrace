package com.forgetrace.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DisputeRequest {

    @NotNull(message = "Choose an order")
    private Long orderId;

    @NotBlank(message = "Give a short reason")
    @Size(max = 160)
    private String reason;

    @Size(max = 4000)
    private String description;
}