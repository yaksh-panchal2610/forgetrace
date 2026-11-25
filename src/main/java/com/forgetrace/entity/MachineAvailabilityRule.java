package com.forgetrace.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

/** Weekly working hours. dayOfWeek: 1 = Monday ... 7 = Sunday. */
@Entity
@Table(name = "machine_availability_rules")
@Getter
@Setter
@NoArgsConstructor
public class MachineAvailabilityRule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "machine_id")
    private Machine machine;

    @Column(nullable = false)
    private Integer dayOfWeek;

    @Column(nullable = false)
    private LocalTime startTime;

    @Column(nullable = false)
    private LocalTime endTime;

    @Column(nullable = false)
    private LocalDate validFrom = LocalDate.now();

    private LocalDate validUntil;

    @Column(nullable = false)
    private boolean active = true;

    public boolean appliesOn(LocalDate date) {
        return active
                && date.getDayOfWeek().getValue() == dayOfWeek
                && !date.isBefore(validFrom)
                && (validUntil == null || !date.isAfter(validUntil));
    }
}