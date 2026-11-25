package com.forgetrace.service;

import com.forgetrace.dto.request.ReviewRequest;
import com.forgetrace.entity.ProductionOrder;
import com.forgetrace.entity.Review;
import com.forgetrace.enums.OrderStatus;
import com.forgetrace.enums.RoleName;
import com.forgetrace.exception.BusinessRuleException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.ProductionOrderRepository;
import com.forgetrace.repository.ReviewRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final ProductionOrderRepository orderRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;
    private final AuditService auditService;

    public record ReviewTarget(Long orderId, String orderNumber, String itemTitle, String manufacturerName) {
    }

    public record ReviewRow(Long id, String orderNumber, String buyerName, String manufacturerName, String reviewerName,
                            int rating, String comment, boolean verifiedPurchase, Instant createdAt) {
    }

    @Transactional(readOnly = true)
    public ReviewTarget target(Long orderId) {
        ProductionOrder order = loadReviewableOrder(orderId);
        return new ReviewTarget(order.getId(), order.getOrderNumber(), order.getRfq().getTitle(),
                order.getManufacturerOrganization().getDisplayName());
    }

    @Transactional
    public void submit(Long orderId, ReviewRequest form) {
        ProductionOrder order = loadReviewableOrder(orderId);
        Long userId = currentUserService.requireUserId();
        Review review = new Review();
        review.setProductionOrder(order);
        review.setBuyerOrganization(order.getBuyerOrganization());
        review.setManufacturerOrganization(order.getManufacturerOrganization());
        review.setReviewer(userRepository.getReferenceById(userId));
        review.setRating(form.getRating());
        review.setComment(form.getComment() == null || form.getComment().isBlank() ? null : form.getComment().trim());
        review.setVerifiedPurchase(true);
        try {
            reviewRepository.saveAndFlush(review);
        } catch (DataIntegrityViolationException ex) {
            throw new BusinessRuleException("You have already reviewed this order.");
        }
        notificationService.notifyOrganization(order.getManufacturerOrganization().getId(),
                "New " + form.getRating() + "-star review", "Order " + order.getOrderNumber(), "/manufacturer/profile");
        auditService.record(userId, "REVIEW_CREATED", "Review", review.getId(), form.getRating() + " stars");
    }

    @Transactional(readOnly = true)
    public Page<ReviewRow> listAll(int page) {
        accessGuard.requireRole(RoleName.ADMIN);
        return reviewRepository.findAll(PageRequest.of(Math.max(page, 0), 20, Sort.by(Sort.Direction.DESC, "createdAt")))
                .map(r -> new ReviewRow(r.getId(), r.getProductionOrder().getOrderNumber(),
                        r.getBuyerOrganization().getDisplayName(), r.getManufacturerOrganization().getDisplayName(),
                        r.getReviewer().getFullName(), r.getRating(), r.getComment(), r.isVerifiedPurchase(), r.getCreatedAt()));
    }

    @Transactional
    public void delete(Long id) {
        accessGuard.requireRole(RoleName.ADMIN);
        Review review = reviewRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Review", id));
        auditService.record(currentUserService.requireUserId(), "REVIEW_REMOVED", "Review", id,
                review.getRating() + " stars: " + (review.getComment() == null ? "" : review.getComment()));
        reviewRepository.delete(review);
    }

    private ProductionOrder loadReviewableOrder(Long orderId) {
        accessGuard.requireRole(RoleName.BUYER);
        Long orgId = currentUserService.requireOrganizationId();
        ProductionOrder order = orderRepository.findWithDetailsById(orderId)
                .filter(o -> o.getBuyerOrganization().getId().equals(orgId))
                .orElseThrow(() -> new ResourceNotFoundException("Order", orderId));
        if (order.getStatus() != OrderStatus.COMPLETED) {
            throw new BusinessRuleException("You can review an order after you mark it completed.");
        }
        if (reviewRepository.existsByProductionOrder_IdAndBuyerOrganization_Id(orderId, orgId)) {
            throw new BusinessRuleException("You have already reviewed this order.");
        }
        return order;
    }
}