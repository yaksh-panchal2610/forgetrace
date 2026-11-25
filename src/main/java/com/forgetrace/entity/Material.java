package com.forgetrace.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "materials")
@Getter
@Setter
@NoArgsConstructor
public class Material {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 80)
    private String materialName;

    @Column(length = 60)
    private String materialCategory;

    @Column(length = 255)
    private String description;

    @Column(nullable = false)
    private boolean active = true;
}