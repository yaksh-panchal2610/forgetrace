package com.forgetrace.security;

import com.forgetrace.entity.OrganizationMember;
import com.forgetrace.entity.User;
import com.forgetrace.repository.OrganizationMemberRepository;
import com.forgetrace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final OrganizationMemberRepository memberRepository;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        String normalized = email == null ? "" : email.trim().toLowerCase(Locale.ROOT);

        User user = userRepository.findByEmailIgnoreCase(normalized)
                .orElseThrow(() -> new UsernameNotFoundException("Invalid email or password"));

        OrganizationMember membership = memberRepository
                .findFirstByUser_IdAndActiveTrue(user.getId())
                .orElse(null);

        return ForgeTraceUserPrincipal.from(user, membership);
    }
}