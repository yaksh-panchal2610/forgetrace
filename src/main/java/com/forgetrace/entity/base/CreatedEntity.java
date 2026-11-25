package com.forgetrace.entity.base;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import lombok.Getter;

import java.time.Instant;

@Getter
@MappedSuperclass
public abstract class CreatedEntity {

    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt;

    @PrePersist
    protected void markCreated() {
        if (createdAt == null) {
            createdAt = Instant.now();
        }
    }
}