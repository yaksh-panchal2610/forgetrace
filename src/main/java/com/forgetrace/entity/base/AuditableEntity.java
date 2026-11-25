package com.forgetrace.entity.base;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.Getter;

import java.time.Instant;

@Getter
@MappedSuperclass
public abstract class AuditableEntity extends CreatedEntity {

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

    @PrePersist
    protected void markInitialUpdate() {
        updatedAt = Instant.now();
    }

    @PreUpdate
    protected void markUpdated() {
        updatedAt = Instant.now();
    }
}