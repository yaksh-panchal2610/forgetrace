package com.forgetrace.support;

import com.forgetrace.entity.Batch;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Rfq;
import com.forgetrace.entity.User;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.VerificationStatus;

import java.math.BigDecimal;
import java.time.LocalDate;

public final class TestData {

    public static final long BUYER_ORG = 10L;
    public static final long MANUFACTURER_ORG = 20L;

    private TestData() {
    }

    public static Organization organization(long id, String name, OrganizationType type) {
        Organization o = new Organization();
        o.setId(id);
        o.setDisplayName(name);
        o.setLegalName(name + " Pvt Ltd");
        o.setOrganizationType(type);
        o.setVerificationStatus(VerificationStatus.VERIFIED);
        return o;
    }

    public static Organization buyer() {
        return organization(BUYER_ORG, "Acme Buyer", OrganizationType.BUYER);
    }

    public static Organization manufacturer() {
        return organization(MANUFACTURER_ORG, "Webmints Works", OrganizationType.MANUFACTURER);
    }

    public static ProductionOrder order(long id, OrderStatus status) {
        Rfq rfq = new Rfq();
        rfq.setTitle("Steel flange");
        rfq.setQuantityUnit("pcs");
        ProductionOrder o = new ProductionOrder();
        o.setId(id);
        o.setOrderNumber("ORD-TEST-" + id);
        o.setRfq(rfq);
        o.setBuyerOrganization(buyer());
        o.setManufacturerOrganization(manufacturer());
        o.setQuantity(new BigDecimal("100"));
        o.setTotalAmount(new BigDecimal("59000.00"));
        o.setCurrency("INR");
        o.setStatus(status);
        return o;
    }

    public static Batch batch(long id, BatchStatus status, ProductionOrder order, String quantity) {
        Batch b = new Batch();
        b.setId(id);
        b.setBatchNumber("BAT-TEST-" + id);
        b.setProductionOrder(order);
        b.setQuantity(new BigDecimal(quantity));
        b.setManufactureDate(LocalDate.now().minusDays(1));
        b.setStatus(status);
        return b;
    }

    public static User user(long id, String name) {
        User u = new User();
        u.setId(id);
        u.setFullName(name);
        u.setEmail(name.toLowerCase().replace(' ', '.') + "@test.local");
        return u;
    }
}