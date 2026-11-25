package com.forgetrace.service;

import com.forgetrace.dto.request.ManufacturerSearchCriteria;
import com.forgetrace.dto.response.ManufacturerCard;
import com.forgetrace.dto.response.ManufacturerDetailView;
import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.entity.Organization;
import com.forgetrace.enums.MachineStatus;
import com.forgetrace.enums.OrganizationType;
import com.forgetrace.enums.VerificationStatus;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.mapper.OrganizationMapper;
import com.forgetrace.repository.MachineRepository;
import com.forgetrace.repository.ManufacturerProfileRepository;
import com.forgetrace.repository.ManufacturingProcessRepository;
import com.forgetrace.repository.MaterialRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Locale;

/**
 * Public manufacturer directory.
 * Only VERIFIED manufacturers are ever shown (test FT-017).
 */
@Service
@RequiredArgsConstructor
public class ManufacturerDirectoryService {

    private final ManufacturerProfileRepository profileRepository;
    private final OrganizationRepository organizationRepository;
    private final MachineRepository machineRepository;
    private final ReviewRepository reviewRepository;
    private final ManufacturingProcessRepository processRepository;
    private final MaterialRepository materialRepository;
    private final OrganizationMapper mapper;

    @Transactional(readOnly = true)
    public List<ManufacturerCard> search(ManufacturerSearchCriteria criteria) {
        ManufacturerSearchCriteria filters = criteria == null ? new ManufacturerSearchCriteria() : criteria;
        return profileRepository.findDirectory(VerificationStatus.VERIFIED).stream()
                .filter(profile -> matches(profile, filters))
                .map(profile -> mapper.toCard(profile, reviewRepository.averageRating(profile.getOrganizationId())))
                .toList();
    }

    @Transactional(readOnly = true)
    public List<ManufacturerCard> featured(int limit) {
        return search(new ManufacturerSearchCriteria()).stream().limit(limit).toList();
    }

    @Transactional(readOnly = true)
    public ManufacturerDetailView getDetail(Long organizationId) {
        ManufacturerProfile profile = profileRepository.findById(organizationId)
                .filter(p -> p.getOrganization().isVerified())
                .orElseThrow(() -> new ResourceNotFoundException("Manufacturer not found."));

        long activeMachines = machineRepository.countByOrganization_IdAndMachineStatus(organizationId, MachineStatus.ACTIVE);
        Double rating = reviewRepository.averageRating(organizationId);
        int reviewCount = reviewRepository.findByManufacturerOrganization_IdOrderByCreatedAtDesc(organizationId).size();
        return mapper.toDetail(profile, activeMachines, rating, reviewCount);
    }

    @Transactional(readOnly = true)
    public long verifiedManufacturerCount() {
        return organizationRepository.countByOrganizationTypeAndVerificationStatus(
                OrganizationType.MANUFACTURER, VerificationStatus.VERIFIED);
    }

    @Transactional(readOnly = true)
    public List<ManufacturingProcess> activeProcesses() {
        return processRepository.findByActiveTrueOrderByProcessNameAsc();
    }

    @Transactional(readOnly = true)
    public List<Material> activeMaterials() {
        return materialRepository.findByActiveTrueOrderByMaterialNameAsc();
    }

    private static boolean matches(ManufacturerProfile profile, ManufacturerSearchCriteria c) {
        Organization org = profile.getOrganization();

        if (c.getProcessId() != null
                && profile.getProcesses().stream().noneMatch(p -> p.getId().equals(c.getProcessId()))) {
            return false;
        }
        if (c.getMaterialId() != null
                && profile.getMaterials().stream().noneMatch(m -> m.getId().equals(c.getMaterialId()))) {
            return false;
        }
        if (c.getCity() != null && !c.getCity().isBlank()
                && !containsIgnoreCase(org.getCity(), c.getCity())) {
            return false;
        }
        if (c.getQ() != null && !c.getQ().isBlank()) {
            return containsIgnoreCase(org.getDisplayName(), c.getQ())
                    || containsIgnoreCase(profile.getDescription(), c.getQ());
        }
        return true;
    }

    private static boolean containsIgnoreCase(String text, String search) {
        return text != null && text.toLowerCase(Locale.ROOT).contains(search.trim().toLowerCase(Locale.ROOT));
    }
}