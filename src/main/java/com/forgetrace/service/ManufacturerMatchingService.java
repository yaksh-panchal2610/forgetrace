package com.forgetrace.service;

import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.repository.ManufacturerProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Decides which manufacturers may see and quote on an RFQ:
 * VERIFIED + offers the RFQ's process + works with the RFQ's material.
 * Tests FT-016 (match verified manufacturer) and FT-017 (exclude unverified).
 */
@Service
@RequiredArgsConstructor
public class ManufacturerMatchingService {

    private final ManufacturerProfileRepository profileRepository;

    @Transactional(readOnly = true)
    public List<Long> matchingManufacturerIds(Long processId, Long materialId) {
        return profileRepository.findMatching(processId, materialId, VerificationStatus.VERIFIED).stream()
                .map(ManufacturerProfile::getOrganizationId)
                .toList();
    }

    @Transactional(readOnly = true)
    public boolean isEligible(Long manufacturerOrganizationId, Long processId, Long materialId) {
        return profileRepository.findById(manufacturerOrganizationId)
                .filter(profile -> profile.getOrganization().isVerified())
                .map(profile ->
                        profile.getProcesses().stream().anyMatch(p -> p.getId().equals(processId))
                                && profile.getMaterials().stream().anyMatch(m -> m.getId().equals(materialId)))
                .orElse(false);
    }
}