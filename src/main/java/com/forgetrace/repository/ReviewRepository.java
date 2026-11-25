package com.forgetrace.repository;

import com.forgetrace.entity.Review;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    boolean existsByProductionOrder_IdAndBuyerOrganization_Id(Long orderId, Long buyerOrganizationId);

    @EntityGraph(attributePaths = "buyerOrganization")
    List<Review> findByManufacturerOrganization_IdOrderByCreatedAtDesc(Long manufacturerId);

    /** Average star rating for a manufacturer, or null if no reviews yet. */
    @Query("select avg(r.rating) from Review r where r.manufacturerOrganization.id = :manufacturerId")
    Double averageRating(@Param("manufacturerId") Long manufacturerId);
}