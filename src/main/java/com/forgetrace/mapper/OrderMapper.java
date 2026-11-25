package com.forgetrace.mapper;

import com.forgetrace.dto.response.OrderTimelineItem;
import com.forgetrace.dto.response.OrderView;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.ProductionOrderEvent;
import com.forgetrace.entity.Quotation;
import com.forgetrace.entity.Rfq;
import org.springframework.stereotype.Component;

@Component
public class OrderMapper {

    public OrderView toView(ProductionOrder order) {
        Rfq rfq = order.getRfq();
        Quotation quotation = order.getAcceptedQuotation();
        return new OrderView(
                order.getId(), order.getOrderNumber(),
                rfq.getId(), rfq.getRfqNumber(), rfq.getTitle(),
                rfq.getProcess().getId(), rfq.getProcess().getProcessName(), rfq.getMaterial().getMaterialName(),
                order.getBuyerOrganization().getId(), order.getBuyerOrganization().getDisplayName(),
                order.getManufacturerOrganization().getId(), order.getManufacturerOrganization().getDisplayName(),
                quotation.getQuotationNumber(), quotation.getLeadTimeDays(),
                order.getQuantity(), rfq.getQuantityUnit(),
                order.getTotalAmount(), order.getCurrency(),
                order.getExpectedCompletion(), rfq.getDeliveryAddress(),
                order.getStatus(), order.getCreatedAt());
    }

    public OrderTimelineItem toTimelineItem(ProductionOrderEvent event) {
        return new OrderTimelineItem(event.getPreviousStatus(), event.getNewStatus(),
                event.getUpdatedBy().getFullName(), event.getNotes(), event.getCreatedAt());
    }
}