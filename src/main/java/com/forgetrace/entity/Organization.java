package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.VerificationStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "organizations")
@Getter
@Setter
@NoArgsConstructor
public class Organization extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String legalName;

    @Column(nullable = false, length = 120)
    private String displayName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private OrganizationType organizationType;

    @Column(length = 60)
    private String registrationNumber;

    @Column(length = 30)
    private String taxId;

    @Column(length = 160)
    private String email;

    @Column(length = 30)
    private String phone;

    @Column(length = 200)
    private String addressLine1;

    @Column(length = 200)
    private String addressLine2;

    @Column(length = 80)
    private String city;

    @Column(length = 80)
    private String state;

    @Column(length = 20)
    private String postalCode;

    @Column(nullable = false, length = 60)
    private String country = "India";

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    public boolean isVerified() {
        return verificationStatus == VerificationStatus.VERIFIED;
    }
}