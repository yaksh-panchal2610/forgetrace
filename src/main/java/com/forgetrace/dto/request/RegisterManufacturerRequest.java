package com.forgetrace.dto.request;

import com.forgetrace.validation.PasswordMatches;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@PasswordMatches
public class RegisterManufacturerRequest {

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

    @Size(max = 60)
    private String registrationNumber;

    /** Indian GSTIN format, optional. Example: 27ABCDE1234F1Z5 */
    @Pattern(regexp = "^$|^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$", message = "Enter a valid GSTIN or leave it empty")
    private String taxId;

    @Min(value = 0, message = "Years cannot be negative")
    @Max(value = 200, message = "Enter a realistic number of years")
    private Integer yearsInOperation;

    @Size(max = 2000)
    private String description;

    @Size(max = 80)
    private String city;

    @Size(max = 80)
    private String state;

    @NotEmpty(message = "Select at least one manufacturing process")
    private List<Long> processIds = new ArrayList<>();

    @NotEmpty(message = "Select at least one material")
    private List<Long> materialIds = new ArrayList<>();

    @AssertTrue(message = "You must accept the terms and privacy notice")
    private boolean acceptTerms;
}