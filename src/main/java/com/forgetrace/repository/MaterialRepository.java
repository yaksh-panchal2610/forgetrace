package com.forgetrace.repository;

import com.forgetrace.entity.Material;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MaterialRepository extends JpaRepository<Material, Long> {

    List<Material> findByActiveTrueOrderByMaterialNameAsc();

    Optional<Material> findByMaterialNameIgnoreCase(String materialName);
}