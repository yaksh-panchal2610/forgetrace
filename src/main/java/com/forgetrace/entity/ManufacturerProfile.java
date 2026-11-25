package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

/** Extra details for a MANUFACTURER organization. Shares its primary key with Organization. */
@Entity
@Table(name = "manufacturer_profiles")
@Getter
@Setter
@NoArgsConstructor
public class ManufacturerProfile extends AuditableEntity {

    @Id
    private Long organizationId;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "organization_id")
    private Organization organization;

    @Column(columnDefinition = "text")
    private String description;

    private Integer yearsInOperation;

    @Column(length = 255)
    private String websiteUrl;

    @Column(columnDefinition = "text")
    private String verificationNotes;

    private Instant approvedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "approved_by")
    private User approvedBy;

    @ManyToMany
    @JoinTable(name = "manufacturer_processes",
            joinColumns = @JoinColumn(name = "manufacturer_id"),
            inverseJoinColumns = @JoinColumn(name = "process_id"))
    private Set<ManufacturingProcess> processes = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "manufacturer_materials",
            joinColumns = @JoinColumn(name = "manufacturer_id"),
            inverseJoinColumns = @JoinColumn(name = "material_id"))
    private Set<Material> materials = new HashSet<>();
}