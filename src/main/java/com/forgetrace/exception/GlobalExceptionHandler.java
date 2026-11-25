package com.forgetrace.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;

import java.time.Instant;

@Slf4j
@ControllerAdvice(basePackages = {
        "com.forgetrace.controller.web",
        "com.forgetrace.controller.buyer",
        "com.forgetrace.controller.manufacturer",
        "com.forgetrace.controller.inspector",
        "com.forgetrace.controller.admin"
})
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ModelAndView handleNotFound(ResourceNotFoundException ex, HttpServletRequest request) {
        return errorView("error/404", HttpStatus.NOT_FOUND, ex.getMessage(), request);
    }

    @ExceptionHandler({UnauthorizedOperationException.class, AccessDeniedException.class})
    public ModelAndView handleForbidden(Exception ex, HttpServletRequest request) {
        log.warn("Access denied on {}: {}", request.getRequestURI(), ex.getMessage());
        return errorView("error/403", HttpStatus.FORBIDDEN, "You do not have permission to do this.", request);
    }

    @ExceptionHandler(ForgeTraceException.class)
    public ModelAndView handleBusiness(ForgeTraceException ex, HttpServletRequest request) {
        return errorView("error/error", ex.getStatus(), ex.getMessage(), request);
    }

    @SuppressWarnings("deprecation")
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ModelAndView handleUploadTooLarge(HttpServletRequest request) {
        return errorView("error/error", HttpStatus.PAYLOAD_TOO_LARGE, "The file is too large. Maximum size is 10 MB.", request);
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleUnexpected(Exception ex, HttpServletRequest request) {
        log.error("Unexpected error on {}", request.getRequestURI(), ex);
        return errorView("error/500", HttpStatus.INTERNAL_SERVER_ERROR,
                "Something went wrong on our side. Please try again.", request);
    }

    private ModelAndView errorView(String view, HttpStatus status, String message, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView(view);
        mav.setStatus(status);
        mav.addObject("status", status.value());
        mav.addObject("error", status.getReasonPhrase());
        mav.addObject("message", message);
        mav.addObject("path", request.getRequestURI());
        mav.addObject("timestamp", Instant.now());
        return mav;
    }
}