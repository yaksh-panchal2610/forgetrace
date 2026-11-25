package com.forgetrace.service;

import com.forgetrace.dto.response.BuyerDashboardView;
import com.forgetrace.dto.response.ManufacturerDashboardView;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Rfq;
import com.forgetrace.enums.MachineStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RfqStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.RfqRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

/** Summary numbers and recent items for each role's dashboard. */
@Service
@RequiredArgsConstructor
public class DashboardService {

    private static final Set<OrderStatus> ACTIVE_ORDER_STATUSES = EnumSet.of(
            OrderStatus.CONFIRMED, OrderStatus.SCHEDULED, OrderStatus.IN_PRODUCTION,
            OrderStatus.QUALITY_CHECK, OrderStatus.READY_TO_SHIP, OrderStatus.SHIPPED, OrderStatus.ON_HOLD);

    private static final Set<OrderStatus> FINISHED_ORDER_STATUSES = EnumSet.of(
            OrderStatus.DELIVERED, OrderStatus.COMPLETED);

    private static final int RECENT_LIMIT = 5;

    private final OrganizationRepository organizationRepository;
    private final RfqRepository rfqRepository;
    private final ProductionOrderRepository orderRepository;
    private final MachineRepository machineRepository;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;

    @Transactional(readOnly = true)
    public BuyerDashboardView buyerDashboard() {
        accessGuard.requireRole(RoleName.BUYER);
        Organization org = currentOrganization();
        Long orgId = org.getId();

        List<BuyerDashboardView.RecentRfq> recentRfqs = rfqRepository
                .findByBuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(0, RECENT_LIMIT))
                .map(this::toRecentRfq)
                .getContent();

        List<BuyerDashboardView.RecentOrder> recentOrders = orderRepository
                .findByBuyerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(0, RECENT_LIMIT))
                .map(o -> toRecentOrder(o, o.getManufacturerOrganization().getDisplayName()))
                .getContent();

        return new BuyerDashboardView(
                org.getDisplayName(),
                rfqRepository.countByBuyerOrganization_IdAndStatus(orgId, RfqStatus.OPEN),
                orderRepository.countByBuyerOrganization_IdAndStatusIn(orgId, ACTIVE_ORDER_STATUSES),
                orderRepository.countByBuyerOrganization_IdAndStatusIn(orgId, FINISHED_ORDER_STATUSES),
                recentRfqs,
                recentOrders
        );
    }

    @Transactional(readOnly = true)
    public ManufacturerDashboardView manufacturerDashboard() {
        accessGuard.requireRole(RoleName.MANUFACTURER);
        Organization org = currentOrganization();
        Long orgId = org.getId();

        // Unverified manufacturers do not receive RFQs yet
        List<Rfq> matching = org.isVerified()
                ? rfqRepository.findOpenMatchingForManufacturer(orgId, RfqStatus.OPEN, Instant.now())
                : List.of();

        List<ManufacturerDashboardView.MatchingRfq> matchingRfqs = matching.stream()
                .limit(RECENT_LIMIT)
                .map(r -> new ManufacturerDashboardView.MatchingRfq(
                        r.getId(), r.getRfqNumber(), r.getTitle(),
                        r.getBuyerOrganization().getDisplayName(),
                        r.getProcess().getProcessName(), r.getMaterial().getMaterialName(),
                        r.getQuantity(), r.getQuantityUnit(), r.getQuoteDeadline()))
                .toList();

        List<BuyerDashboardView.RecentOrder> recentOrders = orderRepository
                .findByManufacturerOrganization_IdOrderByCreatedAtDesc(orgId, PageRequest.of(0, RECENT_LIMIT))
                .map(o -> toRecentOrder(o, o.getBuyerOrganization().getDisplayName()))
                .getContent();

        return new ManufacturerDashboardView(
                org.getDisplayName(),
                org.getVerificationStatus(),
                machineRepository.countByOrganization_IdAndMachineStatus(orgId, MachineStatus.ACTIVE),
                machineRepository.findByOrganization_IdOrderByMachineNameAsc(orgId).size(),
                matching.size(),
                orderRepository.countByManufacturerOrganization_IdAndStatusIn(orgId, ACTIVE_ORDER_STATUSES),
                matchingRfqs,
                recentOrders
        );
    }

    private Organization currentOrganization() {
        Long orgId = currentUserService.requireOrganizationId();
        return organizationRepository.findById(orgId)
                .orElseThrow(() -> new ResourceNotFoundException("Organization", orgId));
    }

    private BuyerDashboardView.RecentRfq toRecentRfq(Rfq rfq) {
        return new BuyerDashboardView.RecentRfq(rfq.getId(), rfq.getRfqNumber(), rfq.getTitle(),
                rfq.getProcess().getProcessName(), rfq.getStatus(), rfq.getQuoteDeadline());
    }

    private BuyerDashboardView.RecentOrder toRecentOrder(ProductionOrder order, String counterpartyName) {
        return new BuyerDashboardView.RecentOrder(order.getId(), order.getOrderNumber(), counterpartyName,
                order.getStatus(), order.getTotalAmount(), order.getCurrency());
    }
}