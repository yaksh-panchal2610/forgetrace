package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.MachineStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "machines")
@Getter
@Setter
@NoArgsConstructor
public class Machine extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "organization_id")
    private Organization organization;

    @Column(nullable = false, length = 120)
    private String machineName;

    @Column(nullable = false, length = 80)
    private String machineType;

    @Column(length = 80)
    private String modelNumber;

    @Column(length = 80)
    private String serialNumber;

    @Column(precision = 12, scale = 2)
    private BigDecimal capacityValue;

    @Column(length = 30)
    private String capacityUnit;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MachineStatus machineStatus = MachineStatus.ACTIVE;

    @Column(length = 160)
    private String location;

    @ManyToMany
    @JoinTable(name = "machine_processes",
            joinColumns = @JoinColumn(name = "machine_id"),
            inverseJoinColumns = @JoinColumn(name = "process_id"))
    private Set<ManufacturingProcess> processes = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "machine_materials",
            joinColumns = @JoinColumn(name = "machine_id"),
            inverseJoinColumns = @JoinColumn(name = "material_id"))
    private Set<Material> materials = new HashSet<>();

    public boolean isBookable() {
        return machineStatus.isBookable();
    }
}