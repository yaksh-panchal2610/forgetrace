package com.forgetrace.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReviewRequest {

    @NotNull(message = "Choose a rating")
    @Min(value = 1, message = "Rating is 1 to 5")
    @Max(value = 5, message = "Rating is 1 to 5")
    private Integer rating = 5;

    @Size(max = 2000)
    private String comment;
}