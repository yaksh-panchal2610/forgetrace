package com.forgetrace.mapper;

import com.forgetrace.dto.request.OrganizationUpdateRequest;
import com.forgetrace.dto.request.ProfileUpdateRequest;
import com.forgetrace.dto.response.ManufacturerCard;
import com.forgetrace.dto.response.ManufacturerDetailView;
import com.forgetrace.entity.ManufacturerProfile;
import com.forgetrace.entity.ManufacturingProcess;
import com.forgetrace.entity.Material;
import com.forgetrace.entity.Organization;
import com.forgetrace.entity.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/** Copies data between entities and DTOs, so controllers and pages never handle entities directly. */
@Component
public class OrganizationMapper {

    private static final int SHORT_DESCRIPTION_LENGTH = 140;

    // ---------- Entity -> form ----------

    public ProfileUpdateRequest toProfileForm(User user) {
        ProfileUpdateRequest form = new ProfileUpdateRequest();
        form.setFullName(user.getFullName());
        form.setPhone(user.getPhone());
        form.setEmail(user.getEmail());
        return form;
    }

    public OrganizationUpdateRequest toOrganizationForm(Organization org, ManufacturerProfile profile) {
        OrganizationUpdateRequest form = new OrganizationUpdateRequest();
        form.setDisplayName(org.getDisplayName());
        form.setLegalName(org.getLegalName());
        form.setRegistrationNumber(org.getRegistrationNumber());
        form.setTaxId(org.getTaxId());
        form.setEmail(org.getEmail());
        form.setPhone(org.getPhone());
        form.setAddressLine1(org.getAddressLine1());
        form.setAddressLine2(org.getAddressLine2());
        form.setCity(org.getCity());
        form.setState(org.getState());
        form.setPostalCode(org.getPostalCode());
        form.setCountry(org.getCountry());
        if (profile != null) {
            form.setDescription(profile.getDescription());
            form.setYearsInOperation(profile.getYearsInOperation());
            form.setWebsiteUrl(profile.getWebsiteUrl());
            form.setProcessIds(new ArrayList<>(profile.getProcesses().stream().map(ManufacturingProcess::getId).toList()));
            form.setMaterialIds(new ArrayList<>(profile.getMaterials().stream().map(Material::getId).toList()));
        }
        return form;
    }

    // ---------- Form -> entity ----------

    public void applyToUser(ProfileUpdateRequest form, User user) {
        user.setFullName(form.getFullName().trim());
        user.setPhone(blankToNull(form.getPhone()));
    }

    public void applyToOrganization(OrganizationUpdateRequest form, Organization org) {
        org.setDisplayName(form.getDisplayName().trim());
        org.setLegalName(form.getLegalName().trim());
        org.setRegistrationNumber(blankToNull(form.getRegistrationNumber()));
        org.setTaxId(blankToNull(form.getTaxId()));
        org.setEmail(blankToNull(form.getEmail()));
        org.setPhone(blankToNull(form.getPhone()));
        org.setAddressLine1(blankToNull(form.getAddressLine1()));
        org.setAddressLine2(blankToNull(form.getAddressLine2()));
        org.setCity(blankToNull(form.getCity()));
        org.setState(blankToNull(form.getState()));
        org.setPostalCode(blankToNull(form.getPostalCode()));
        org.setCountry(form.getCountry().trim());
    }

    public void applyToProfile(OrganizationUpdateRequest form, ManufacturerProfile profile,
                               Collection<ManufacturingProcess> processes, Collection<Material> materials) {
        profile.setDescription(blankToNull(form.getDescription()));
        profile.setYearsInOperation(form.getYearsInOperation());
        profile.setWebsiteUrl(blankToNull(form.getWebsiteUrl()));
        profile.getProcesses().clear();
        profile.getProcesses().addAll(processes);
        profile.getMaterials().clear();
        profile.getMaterials().addAll(materials);
    }

    // ---------- Entity -> public views ----------

    public ManufacturerCard toCard(ManufacturerProfile profile, Double averageRating) {
        Organization org = profile.getOrganization();
        return new ManufacturerCard(
                org.getId(),
                org.getDisplayName(),
                location(org),
                profile.getYearsInOperation(),
                shorten(profile.getDescription()),
                processNames(profile),
                materialNames(profile),
                averageRating
        );
    }

    public ManufacturerDetailView toDetail(ManufacturerProfile profile, long activeMachines,
                                           Double averageRating, int reviewCount) {
        Organization org = profile.getOrganization();
        return new ManufacturerDetailView(
                org.getId(),
                org.getDisplayName(),
                location(org),
                profile.getYearsInOperation(),
                profile.getDescription(),
                profile.getWebsiteUrl(),
                processNames(profile),
                materialNames(profile),
                activeMachines,
                averageRating,
                reviewCount,
                org.getCreatedAt()
        );
    }

    // ---------- helpers ----------

    private static List<String> processNames(ManufacturerProfile profile) {
        return profile.getProcesses().stream().map(ManufacturingProcess::getProcessName).sorted().toList();
    }

    private static List<String> materialNames(ManufacturerProfile profile) {
        return profile.getMaterials().stream().map(Material::getMaterialName).sorted().toList();
    }

    static String location(Organization org) {
        if (org.getCity() != null && org.getState() != null) {
            return org.getCity() + ", " + org.getState();
        }
        if (org.getCity() != null) {
            return org.getCity();
        }
        return org.getState() != null ? org.getState() : org.getCountry();
    }

    private static String shorten(String text) {
        if (text == null || text.length() <= SHORT_DESCRIPTION_LENGTH) {
            return text;
        }
        return text.substring(0, SHORT_DESCRIPTION_LENGTH).trim() + "…";
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}