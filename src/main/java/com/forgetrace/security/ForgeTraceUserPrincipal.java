package com.forgetrace.security;

import com.forgetrace.entity.OrganizationMember;
import com.forgetrace.entity.User;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.RoleName;
import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serializable;
import java.util.Collection;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

@SuppressWarnings("unused")
public class ForgeTraceUserPrincipal implements UserDetails, CredentialsContainer, Serializable {

    private final Long id;
    private final String email;
    private final String fullName;
    private String passwordHash;
    private final boolean enabled;
    private final Set<RoleName> roles;
    private final List<GrantedAuthority> authorities;
    private final Long organizationId;
    private final String organizationName;
    private final OrganizationType organizationType;

    private ForgeTraceUserPrincipal(User user, OrganizationMember membership) {
        this.id = user.getId();
        this.email = user.getEmail();
        this.fullName = user.getFullName();
        this.passwordHash = user.getPasswordHash();
        this.enabled = user.getAccountStatus().canLogin();

        Set<RoleName> roleNames = EnumSet.noneOf(RoleName.class);
        user.getRoles().forEach(role -> roleNames.add(role.getRoleName()));
        this.roles = roleNames;
        this.authorities = roleNames.stream()
                .map(role -> (GrantedAuthority) new SimpleGrantedAuthority(role.authority()))
                .toList();

        if (membership != null) {
            this.organizationId = membership.getOrganization().getId();
            this.organizationName = membership.getOrganization().getDisplayName();
            this.organizationType = membership.getOrganization().getOrganizationType();
        } else {
            this.organizationId = null;
            this.organizationName = null;
            this.organizationType = null;
        }
    }

    public static ForgeTraceUserPrincipal from(User user, OrganizationMember membership) {
        return new ForgeTraceUserPrincipal(user, membership);
    }

    public boolean hasRole(RoleName role) {
        return roles.contains(role);
    }

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getFullName() {
        return fullName;
    }

    public Set<RoleName> getRoles() {
        return roles;
    }

    public Long getOrganizationId() {
        return organizationId;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public OrganizationType getOrganizationType() {
        return organizationType;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return passwordHash;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    /** Spring calls this after login so the password hash is not kept in the session. */
    @Override
    public void eraseCredentials() {
        this.passwordHash = null;
    }
}