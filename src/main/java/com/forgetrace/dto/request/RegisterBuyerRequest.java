package com.forgetrace.dto.request;

import com.forgetrace.validation.PasswordMatches;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@PasswordMatches
public class RegisterBuyerRequest {

    @NotBlank(message = "Full name is required")
    @Size(max = 120)
    private String fullName;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email address")
    @Size(max = 160)
    private String email;

    @Pattern(regexp = "^$|^\\+?[0-9][0-9 -]{7,18}$", message = "Enter a valid phone number")
    private String phone;

    @NotBlank(message = "Password is required")
    @Size(min = 8, max = 72, message = "Password must be 8 to 72 characters")
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d).+$", message = "Password must contain at least one letter and one number")
    private String password;

    @NotBlank(message = "Please confirm your password")
    private String confirmPassword;

    @NotBlank(message = "Company name is required")
    @Size(max = 200)
    private String companyName;

    @Size(max = 80)
    private String city;

    @Size(max = 80)
    private String state;

    /** Explicit consent - required by the e-commerce privacy checklist. */
    @AssertTrue(message = "You must accept the terms and privacy notice")
    private boolean acceptTerms;
}