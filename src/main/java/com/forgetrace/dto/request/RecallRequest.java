package com.forgetrace.dto.request;

import com.forgetrace.enums.RecallSeverity;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RecallRequest {

    @NotNull
    private Long batchId;

    @NotNull(message = "Choose a severity")
    private RecallSeverity severity = RecallSeverity.HIGH;

    @NotBlank(message = "Explain why the batch is recalled")
    @Size(max = 4000)
    private String reason;
}