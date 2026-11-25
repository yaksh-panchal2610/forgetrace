package com.forgetrace.service;

import com.forgetrace.entity.User;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Locale;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public User getById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", id));
    }

    @Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        if (email == null) {
            return Optional.empty();
        }
        return userRepository.findByEmailIgnoreCase(email.trim().toLowerCase(Locale.ROOT));
    }

    @Transactional
    public void recordSuccessfulLogin(Long userId) {
        userRepository.findById(userId).ifPresent(user -> user.setLastLoginAt(Instant.now()));
    }
}