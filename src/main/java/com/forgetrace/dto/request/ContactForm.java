package com.forgetrace.dto.request;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ContactForm {

    @NotBlank(message = "Name is required")
    @Size(max = 120)
    private String name;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email address")
    @Size(max = 160)
    private String email;

    @NotBlank(message = "Subject is required")
    @Size(max = 160)
    private String subject;

    @NotBlank(message = "Message is required")
    @Size(max = 4000, message = "Message is too long (max 4000 characters)")
    private String message;

    /** Consent to store the message - required by the privacy checklist. */
    @AssertTrue(message = "Please allow us to store your message so we can reply")
    private boolean consent;
}