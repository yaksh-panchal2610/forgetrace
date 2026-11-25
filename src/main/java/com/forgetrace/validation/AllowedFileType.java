package com.forgetrace.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Constraint(validatedBy = AllowedFileTypeValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface AllowedFileType {

    String message() default "File type is not allowed";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    /** Lowercase extensions without the dot. */
    String[] extensions() default {"pdf", "png", "jpg", "jpeg", "dxf", "step", "stp", "csv"};

    long maxSizeMb() default 10;
}