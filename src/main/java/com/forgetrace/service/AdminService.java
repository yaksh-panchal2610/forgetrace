package com.forgetrace.service;

import com.forgetrace.dto.response.AdminDashboardView;
import com.forgetrace.dto.response.BatchView;
import com.forgetrace.dto.response.PaymentResult;
import com.forgetrace.entity.AuditLog;
import com.forgetrace.entity.ContactRequest;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.Payment;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.User;
import com.forgetrace.enums.AccountStatus;
import com.forgetrace.enums.BatchStatus;
import com.forgetrace.enums.ContactStatus;
import com.forgetrace.enums.DisputeStatus;
import com.forgetrace.enums.MachineStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.PaymentStatus;
import com.forgetrace.enums.RecallStatus;
import com.forgetrace.enums.RfqStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.AuditLogRepository;
import com.forgetrace.repository.BatchRepository;
import com.forgetrace.repository.ContactRequestRepository;
import com.forgetrace.repository.DisputeRepository;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.OrganizationMemberRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.PaymentRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.RecallRepository;
import com.forgetrace.repository.RfqRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminService {

    private static final Set<OrderStatus> ACTIVE_ORDERS = EnumSet.of(OrderStatus.CONFIRMED, OrderStatus.SCHEDULED,
            OrderStatus.IN_PRODUCTION, OrderStatus.QUALITY_CHECK, OrderStatus.READY_TO_SHIP, OrderStatus.SHIPPED, OrderStatus.ON_HOLD);
    private static final DateTimeFormatter DAY = DateTimeFormatter.ofPattern("dd MMM", Locale.ENGLISH);
    private static final int PAGE_SIZE = 20;

    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final OrganizationMemberRepository memberRepository;
    private final ProductionOrderRepository orderRepository;
    private final PaymentRepository paymentRepository;
    private final BatchRepository batchRepository;
    private final DisputeRepository disputeRepository;
    private final RecallRepository recallRepository;
    private final ContactRequestRepository contactRepository;
    private final AuditLogRepository auditLogRepository;
    private final RfqRepository rfqRepository;
    private final MachineRepository machineRepository;
    private final BatchService batchService;
    private final AccessGuard accessGuard;
    private final CurrentUserService currentUserService;
    private final AuditService auditService;

    @Value("${app.display-zone:Asia/Kolkata}")
    private String displayZone;

    public record UserRow(Long id, String fullName, String email, String roles, String organizationName,
                          AccountStatus status, Instant lastLoginAt, Instant createdAt, boolean self, boolean admin) {
    }

    public record RfqRow(Long id, String rfqNumber, String title, String buyerName, String processName,
                         String materialName, RfqStatus status, Instant createdAt) {
    }

    public record OrderRow(Long id, String orderNumber, String itemTitle, String buyerName, String manufacturerName,
                           BigDecimal totalAmount, String currency, OrderStatus status, Instant createdAt) {
    }

    public record MachineRow(Long id, String machineName, String machineType, String organizationName, MachineStatus status) {
    }

    @Transactional(readOnly = true)
    public AdminDashboardView dashboard() {
        requireAdmin();
        ZoneId zone = ZoneId.of(displayZone);

        List<String> statusLabels = new ArrayList<>();
        List<Long> statusCounts = new ArrayList<>();
        for (OrderStatus s : OrderStatus.values()) {
            statusLabels.add(s.getLabel());
            statusCounts.add(orderRepository.countByStatus(s));
        }
        long activeOrders = ACTIVE_ORDERS.stream().mapToLong(orderRepository::countByStatus).sum();

        LocalDate today = LocalDate.now(zone);
        Map<LocalDate, BigDecimal> perDay = new LinkedHashMap<>();
        for (int i = 13; i >= 0; i--) {
            perDay.put(today.minusDays(i), BigDecimal.ZERO);
        }
        for (Payment p : paymentRepository.findAll()) {
            if (p.getStatus() == PaymentStatus.SUCCEEDED && p.getPaidAt() != null) {
                LocalDate day = LocalDate.ofInstant(p.getPaidAt(), zone);
                if (perDay.containsKey(day)) {
                    perDay.merge(day, p.getAmount(), BigDecimal::add);
                }
            }
        }
        BigDecimal revenue = perDay.values().stream().reduce(BigDecimal.ZERO, BigDecimal::add);

        List<AdminDashboardView.AuditRow> recent = auditLogRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(0, 8))
                .map(this::toAuditRow).getContent();

        return new AdminDashboardView(
                organizationRepository.countByOrganizationTypeAndVerificationStatus(OrganizationType.MANUFACTURER, VerificationStatus.PENDING),
                organizationRepository.countByOrganizationTypeAndVerificationStatus(OrganizationType.MANUFACTURER, VerificationStatus.VERIFIED),
                userRepository.countByAccountStatus(AccountStatus.ACTIVE),
                userRepository.countByAccountStatus(AccountStatus.SUSPENDED),
                activeOrders,
                disputeRepository.countByStatus(DisputeStatus.OPEN) + disputeRepository.countByStatus(DisputeStatus.UNDER_REVIEW),
                recallRepository.countByStatusNot(RecallStatus.CLOSED),
                batchRepository.countByStatus(BatchStatus.AWAITING_INSPECTION),
                contactRepository.countByStatus(ContactStatus.NEW),
                revenue,
                statusLabels,
                statusCounts,
                perDay.keySet().stream().map(DAY::format).toList(),
                new ArrayList<>(perDay.values()),
                recent);
    }

    @Transactional(readOnly = true)
    public Page<UserRow> users(int page) {
        requireAdmin();
        Long me = currentUserService.requireUserId();
        return userRepository.findAll(pageable(page, "createdAt")).map(u -> new UserRow(u.getId(), u.getFullName(), u.getEmail(),
                u.getRoles().stream().map(r -> r.getRoleName().name()).sorted().collect(Collectors.joining(", ")),
                memberRepository.findFirstByUser_IdAndActiveTrue(u.getId()).map(m -> m.getOrganization().getDisplayName()).orElse("-"),
                u.getAccountStatus(), u.getLastLoginAt(), u.getCreatedAt(), u.getId().equals(me), u.hasRole(RoleName.ADMIN)));
    }

    @Transactional
    public void setUserStatus(Long userId, AccountStatus status) {
        requireAdmin();
        Long me = currentUserService.requireUserId();
        if (status != AccountStatus.ACTIVE && status != AccountStatus.SUSPENDED) {
            throw new BusinessRuleException("Choose Active or Suspended.");
        }
        User user = userRepository.findById(userId).orElseThrow(() -> new ResourceNotFoundException("User", userId));
        if (user.getId().equals(me)) {
            throw new BusinessRuleException("You cannot change your own account.");
        }
        if (user.hasRole(RoleName.ADMIN) && status == AccountStatus.SUSPENDED) {
            throw new BusinessRuleException("Admin accounts cannot be suspended here.");
        }
        user.setAccountStatus(status);
        auditService.record(me, status == AccountStatus.SUSPENDED ? "USER_SUSPENDED" : "USER_ACTIVATED", "User", userId, user.getEmail());
    }

    @Transactional(readOnly = true)
    public Page<Organization> organizations(int page) {
        requireAdmin();
        return organizationRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(Math.max(page, 0), PAGE_SIZE));
    }

    @Transactional(readOnly = true)
    public Page<RfqRow> rfqs(int page) {
        requireAdmin();
        return rfqRepository.findAll(pageable(page, "createdAt")).map(r -> new RfqRow(r.getId(), r.getRfqNumber(), r.getTitle(),
                r.getBuyerOrganization().getDisplayName(), r.getProcess().getProcessName(), r.getMaterial().getMaterialName(),
                r.getStatus(), r.getCreatedAt()));
    }

    @Transactional(readOnly = true)
    public Page<OrderRow> orders(int page) {
        requireAdmin();
        return orderRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(Math.max(page, 0), PAGE_SIZE)).map(this::toOrderRow);
    }

    @Transactional(readOnly = true)
    public Page<MachineRow> machines(int page) {
        requireAdmin();
        return machineRepository.findAll(pageable(page, "id")).map(m -> new MachineRow(m.getId(), m.getMachineName(),
                m.getMachineType(), m.getOrganization().getDisplayName(), m.getMachineStatus()));
    }

    @Transactional(readOnly = true)
    public Page<BatchView> batches(int page) {
        requireAdmin();
        return batchRepository.findAll(pageable(page, "createdAt")).map(batchService::toView);
    }

    @Transactional(readOnly = true)
    public Page<PaymentResult> payments(int page) {
        requireAdmin();
        return paymentRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(Math.max(page, 0), PAGE_SIZE)).map(p -> {
            ProductionOrder o = p.getProductionOrder();
            return new PaymentResult(p.getId(), p.getPaymentReference(), o.getId(), o.getOrderNumber(),
                    o.getBuyerOrganization().getDisplayName(), o.getManufacturerOrganization().getDisplayName(),
                    p.getAmount(), p.getCurrency(), p.getPaymentMethod(), p.getStatus(), p.getFailureReason(),
                    p.getProviderReference(), p.getPaidAt(), p.getCreatedAt(), false);
        });
    }

    @Transactional(readOnly = true)
    public Page<AdminDashboardView.AuditRow> auditLogs(int page) {
        requireAdmin();
        return auditLogRepository.findAllByOrderByCreatedAtDesc(PageRequest.of(Math.max(page, 0), 30)).map(this::toAuditRow);
    }

    @Transactional(readOnly = true)
    public Page<ContactRequest> contacts(int page) {
        requireAdmin();
        return contactRepository.findAll(pageable(page, "createdAt"));
    }

    @Transactional
    public void setContactStatus(Long id, ContactStatus status) {
        requireAdmin();
        ContactRequest request = contactRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Contact request", id));
        request.setStatus(status);
        auditService.record(currentUserService.requireUserId(), "CONTACT_STATUS", "ContactRequest", id, status.name());
    }

    private OrderRow toOrderRow(ProductionOrder o) {
        return new OrderRow(o.getId(), o.getOrderNumber(), o.getRfq().getTitle(), o.getBuyerOrganization().getDisplayName(),
                o.getManufacturerOrganization().getDisplayName(), o.getTotalAmount(), o.getCurrency(), o.getStatus(), o.getCreatedAt());
    }

    private AdminDashboardView.AuditRow toAuditRow(AuditLog log) {
        return new AdminDashboardView.AuditRow(log.getCreatedAt(),
                log.getActorUser() == null ? "system" : log.getActorUser().getEmail(),
                log.getAction(), log.getEntityType(), log.getEntityId(), log.getDetails(), log.getIpAddress());
    }

    private static PageRequest pageable(int page, String sortField) {
        return PageRequest.of(Math.max(page, 0), PAGE_SIZE, Sort.by(Sort.Direction.DESC, sortField));
    }

    private void requireAdmin() {
        accessGuard.requireRole(RoleName.ADMIN);
    }
}