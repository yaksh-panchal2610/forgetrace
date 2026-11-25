package com.forgetrace.service;

import com.forgetrace.entity.Dispute;
import com.forgetrace.enums.DisputeStatus;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.repository.DisputeRepository;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.support.TestData;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class DisputeServiceTest {

    @Mock DisputeRepository disputeRepository;
    @Mock ProductionOrderRepository orderRepository;
    @Mock UserRepository userRepository;
    @Mock NotificationService notificationService;
    @Mock CurrentUserService currentUserService;
    @Mock AccessGuard accessGuard;
    @Mock AuditService auditService;

    @InjectMocks DisputeService service;

    private Dispute dispute;

    @BeforeEach
    void setUp() {
        dispute = new Dispute();
        dispute.setId(1L);
        dispute.setProductionOrder(TestData.order(1L, OrderStatus.DELIVERED));
        dispute.setOpenedBy(TestData.user(3L, "Buyer User"));
        dispute.setReason("20 parts out of tolerance");
        dispute.setStatus(DisputeStatus.OPEN);
        when(disputeRepository.findById(1L)).thenReturn(Optional.of(dispute));
        when(currentUserService.requireUserId()).thenReturn(1L);
        when(userRepository.getReferenceById(1L)).thenReturn(TestData.user(1L, "Admin"));
    }

    @Test
    void closedDisputesCannotChange() {
        assertThat(DisputeService.nextStatuses(DisputeStatus.RESOLVED)).isEmpty();
        assertThat(DisputeService.nextStatuses(DisputeStatus.OPEN)).contains(DisputeStatus.UNDER_REVIEW, DisputeStatus.RESOLVED);
    }

    @Test
    void resolvingNeedsAResolutionText() {
        assertThatThrownBy(() -> service.update(1L, DisputeStatus.RESOLVED, "   "))
                .isInstanceOf(BusinessRuleException.class)
                .hasMessageContaining("resolution");
        assertThat(dispute.getStatus()).isEqualTo(DisputeStatus.OPEN);
    }

    @Test
    void resolvingNotifiesBothParties() {
        service.update(1L, DisputeStatus.RESOLVED, "Manufacturer replaces 20 pcs.");

        assertThat(dispute.getStatus()).isEqualTo(DisputeStatus.RESOLVED);
        assertThat(dispute.getResolvedAt()).isNotNull();
        verify(notificationService).notifyOrganization(eq(TestData.BUYER_ORG), anyString(), anyString(), anyString());
        verify(notificationService).notifyOrganization(eq(TestData.MANUFACTURER_ORG), anyString(), anyString(), anyString());
    }

    @Test
    void cannotReopenAnOpenDispute() {
        assertThatThrownBy(() -> service.update(1L, DisputeStatus.OPEN, null))
                .isInstanceOf(BusinessRuleException.class);
    }
}