package com.forgetrace.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProfileUpdateRequest {

    @NotBlank(message = "Full name is required")
    @Size(max = 120)
    private String fullName;

    @Pattern(regexp = "^$|^\\+?[0-9][0-9 -]{7,18}$", message = "Enter a valid phone number")
    private String phone;

    private String email;
}