package com.forgetrace.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

public class DateRangeValidator implements ConstraintValidator<ValidDateRange, Object> {

    private String startField;
    private String endField;
    private boolean allowEqual;
    private String message;

    @Override
    public void initialize(ValidDateRange annotation) {
        this.startField = annotation.startField();
        this.endField = annotation.endField();
        this.allowEqual = annotation.allowEqual();
        this.message = annotation.message();
    }

    @Override
    @SuppressWarnings({"unchecked", "rawtypes"})
    public boolean isValid(Object form, ConstraintValidatorContext context) {
        if (form == null) {
            return true;
        }
        BeanWrapper wrapper = new BeanWrapperImpl(form);
        Object start = wrapper.getPropertyValue(startField);
        Object end = wrapper.getPropertyValue(endField);

        if (!(start instanceof Comparable startValue) || !(end instanceof Comparable)) {
            return true;
        }

        int comparison = startValue.compareTo(end);
        boolean valid = allowEqual ? comparison <= 0 : comparison < 0;
        if (!valid) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(message)
                    .addPropertyNode(endField)
                    .addConstraintViolation();
        }
        return valid;
    }
}