package com.forgetrace.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

import java.util.Objects;

public class PasswordMatchesValidator implements ConstraintValidator<PasswordMatches, Object> {

    private String passwordField;
    private String confirmField;
    private String message;

    @Override
    public void initialize(PasswordMatches annotation) {
        this.passwordField = annotation.passwordField();
        this.confirmField = annotation.confirmField();
        this.message = annotation.message();
    }

    @Override
    public boolean isValid(Object form, ConstraintValidatorContext context) {
        if (form == null) {
            return true;
        }
        BeanWrapper wrapper = new BeanWrapperImpl(form);
        Object password = wrapper.getPropertyValue(passwordField);
        Object confirm = wrapper.getPropertyValue(confirmField);

        boolean matches = Objects.equals(password, confirm);
        if (!matches) {
            // Show the error under the "confirm password" field instead of at the top of the form
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(message)
                    .addPropertyNode(confirmField)
                    .addConstraintViolation();
        }
        return matches;
    }
}