package com.forgetrace.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
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
public class OrganizationUpdateRequest {

    @NotBlank(message = "Display name is required")
    @Size(max = 120)
    private String displayName;

    @NotBlank(message = "Legal name is required")
    @Size(max = 200)
    private String legalName;

    @Size(max = 60)
    private String registrationNumber;

    @Pattern(regexp = "^$|^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$", message = "Enter a valid GSTIN or leave it empty")
    private String taxId;

    @Email(message = "Enter a valid email address")
    @Size(max = 160)
    private String email;

    @Pattern(regexp = "^$|^\\+?[0-9][0-9 -]{7,18}$", message = "Enter a valid phone number")
    private String phone;

    @Size(max = 200)
    private String addressLine1;

    @Size(max = 200)
    private String addressLine2;

    @Size(max = 80)
    private String city;

    @Size(max = 80)
    private String state;

    @Pattern(regexp = "^$|^[1-9][0-9]{5}$", message = "Enter a valid 6-digit PIN code")
    private String postalCode;

    @NotBlank(message = "Country is required")
    @Size(max = 60)
    private String country;

    @Size(max = 2000)
    private String description;

    @Min(value = 0, message = "Years cannot be negative")
    @Max(value = 200, message = "Enter a realistic number of years")
    private Integer yearsInOperation;

    @Pattern(regexp = "^$|^https?://.+", message = "Website must start with http:// or https://")
    @Size(max = 255)
    private String websiteUrl;

    private List<Long> processIds = new ArrayList<>();

    private List<Long> materialIds = new ArrayList<>();
}