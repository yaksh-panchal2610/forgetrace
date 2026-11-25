package com.forgetrace.repository;

import com.forgetrace.entity.OrganizationMember;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrganizationMemberRepository extends JpaRepository<OrganizationMember, Long> {

    /** The organization a logged-in user belongs to (loads the organization too). */
    @EntityGraph(attributePaths = "organization")
    Optional<OrganizationMember> findFirstByUser_IdAndActiveTrue(Long userId);

    boolean existsByOrganization_IdAndUser_IdAndActiveTrue(Long organizationId, Long userId);

    @EntityGraph(attributePaths = "user")
    List<OrganizationMember> findByOrganization_IdAndActiveTrue(Long organizationId);
}