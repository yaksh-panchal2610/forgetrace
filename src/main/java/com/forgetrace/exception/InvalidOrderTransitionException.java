package com.forgetrace.exception;

import com.forgetrace.enums.OrderStatus;

public class InvalidOrderTransitionException extends BusinessRuleException {

    public InvalidOrderTransitionException(OrderStatus from, OrderStatus to) {
        super("An order cannot move from '" + from.getLabel() + "' to '" + to.getLabel() + "'.");
    }

    public InvalidOrderTransitionException(String message) {
        super(message);
    }
}