package com.forgetrace.entity;

import com.forgetrace.entity.base.CreatedEntity;
import com.forgetrace.enums.PassportVisibility;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "product_passports")
@Getter
@Setter
@NoArgsConstructor
public class ProductPassport extends CreatedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "batch_id", unique = true)
    private Batch batch;

    /** Random, non-guessable token used in the public QR URL /p/{token}. */
    @Column(nullable = false, unique = true)
    private UUID publicToken;

    @Column(length = 500)
    private String qrFileKey;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private PassportVisibility visibilityStatus = PassportVisibility.PUBLIC;

    private Instant publishedAt;

    private Instant revokedAt;

    public boolean isPubliclyVisible() {
        return visibilityStatus == PassportVisibility.PUBLIC && revokedAt == null;
    }
}