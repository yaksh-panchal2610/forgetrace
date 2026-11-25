package com.forgetrace.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "manufacturing_processes")
@Getter
@Setter
@NoArgsConstructor
public class ManufacturingProcess {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 80)
    private String processName;

    @Column(length = 255)
    private String description;

    @Column(nullable = false)
    private boolean active = true;
}