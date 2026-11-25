package com.forgetrace.repository;

import com.forgetrace.entity.User;
import com.forgetrace.enums.AccountStatus;
import com.forgetrace.enums.RoleName;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmailIgnoreCase(String email);

    boolean existsByEmailIgnoreCase(String email);

    List<User> findByRoles_RoleName(RoleName roleName);

    long countByAccountStatus(AccountStatus status);
}