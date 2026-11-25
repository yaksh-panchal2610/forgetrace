package com.forgetrace.exception;

public class QuotationExpiredException extends BusinessRuleException {

    public QuotationExpiredException(String quotationNumber) {
        super("Quotation " + quotationNumber + " has expired and can no longer be accepted.");
    }
}