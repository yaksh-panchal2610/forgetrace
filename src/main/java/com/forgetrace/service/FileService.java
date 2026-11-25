package com.forgetrace.service;

import com.forgetrace.config.StorageProperties;
import com.forgetrace.entity.FileObject;
import com.forgetrace.entity.Rfq;
import com.forgetrace.entity.RfqAttachment;
import com.forgetrace.exception.FileValidationException;
import com.forgetrace.exception.ResourceNotFoundException;
import com.forgetrace.exception.UnauthorizedOperationException;
import com.forgetrace.repository.FileObjectRepository;
import com.forgetrace.repository.OrganizationRepository;
import com.forgetrace.repository.RfqAttachmentRepository;
import com.forgetrace.repository.UserRepository;
import com.forgetrace.security.AccessGuard;
import com.forgetrace.security.CurrentUserService;
import com.forgetrace.security.ForgeTraceUserPrincipal;
import com.forgetrace.storage.FileStorageService;
import com.forgetrace.storage.StoredFile;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Validates, stores and serves uploaded files.
 * Checks are done on the server: extension, size, real file signature and who may download.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class FileService {

    private static final Map<String, String> CONTENT_TYPES = Map.of(
            "pdf", "application/pdf",
            "png", "image/png",
            "jpg", "image/jpeg",
            "jpeg", "image/jpeg",
            "dxf", "application/dxf",
            "step", "application/step",
            "stp", "application/step",
            "csv", "text/csv");

    private final FileStorageService storage;
    private final FileObjectRepository fileObjectRepository;
    private final RfqAttachmentRepository rfqAttachmentRepository;
    private final UserRepository userRepository;
    private final OrganizationRepository organizationRepository;
    private final ManufacturerMatchingService matchingService;
    private final StorageProperties storageProperties;
    private final CurrentUserService currentUserService;
    private final AccessGuard accessGuard;

    /** A file ready to be streamed to the browser. */
    public record DownloadableFile(String filename, String contentType, long sizeBytes, InputStream content) {
    }

    @Transactional
    public FileObject upload(MultipartFile file, String folder) {
        String extension = validate(file);
        String contentType = CONTENT_TYPES.getOrDefault(extension, "application/octet-stream");
        ForgeTraceUserPrincipal user = currentUserService.requirePrincipal();

        StoredFile stored;
        try (InputStream content = file.getInputStream()) {
            stored = storage.store(folder, extension, contentType, file.getSize(), content);
        } catch (IOException ex) {
            log.error("Could not store upload", ex);
            throw new FileValidationException("The file could not be saved. Please try again.");
        }

        FileObject fileObject = new FileObject();
        fileObject.setBucket(stored.bucket());
        fileObject.setObjectKey(stored.objectKey());
        fileObject.setOriginalFilename(safeFilename(file.getOriginalFilename()));
        fileObject.setContentType(contentType);
        fileObject.setSizeBytes(stored.sizeBytes());
        fileObject.setUploadedBy(userRepository.getReferenceById(user.getId()));
        if (user.getOrganizationId() != null) {
            fileObject.setOrganization(organizationRepository.getReferenceById(user.getOrganizationId()));
        }
        return fileObjectRepository.save(fileObject);
    }

    @Transactional(readOnly = true)
    public DownloadableFile openForDownload(Long fileId) {
        FileObject fileObject = fileObjectRepository.findById(fileId)
                .orElseThrow(() -> new ResourceNotFoundException("File", fileId));
        if (!canAccess(fileObject)) {
            throw new UnauthorizedOperationException("You do not have access to this file.");
        }
        try {
            return new DownloadableFile(fileObject.getOriginalFilename(), fileObject.getContentType(),
                    fileObject.getSizeBytes(), storage.load(fileObject.getObjectKey()));
        } catch (IOException ex) {
            log.error("File {} missing from storage", fileObject.getObjectKey(), ex);
            throw new ResourceNotFoundException("The file is no longer available.");
        }
    }

    /**
     * Who may download (test FT-034):
     * 1. admins,
     * 2. members of the organization that uploaded the file,
     * 3. for RFQ drawings: verified manufacturers that match the RFQ's process and material.
     */
    public boolean canAccess(FileObject fileObject) {
        if (accessGuard.isAdmin() || currentUserService.hasRole(com.forgetrace.enums.RoleName.QUALITY_INSPECTOR)) {
            return true;
        }
        Long ownerOrganizationId = fileObject.getOrganization() == null ? null : fileObject.getOrganization().getId();
        if (ownerOrganizationId != null && accessGuard.isMemberOfAny(ownerOrganizationId)) {
            return true;
        }
        Long currentOrganizationId = currentUserService.findPrincipal()
                .map(ForgeTraceUserPrincipal::getOrganizationId)
                .orElse(null);
        if (currentOrganizationId == null) {
            return false;
        }
        List<RfqAttachment> links = rfqAttachmentRepository.findByFile_Id(fileObject.getId());
        for (RfqAttachment link : links) {
            Rfq rfq = link.getRfq();
            if (matchingService.isEligible(currentOrganizationId, rfq.getProcess().getId(), rfq.getMaterial().getId())) {
                return true;
            }
        }
        return false;
    }

    // ---------- validation ----------

    /** Throws FileValidationException if the file is not acceptable; returns its extension. */
    public String validate(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new FileValidationException("Please choose a file to upload.");
        }
        long maxBytes = storageProperties.getMaxFileSizeMb() * 1024 * 1024;
        if (file.getSize() > maxBytes) {
            throw new FileValidationException("'" + safeFilename(file.getOriginalFilename()) + "' is too large. Maximum size is "
                    + storageProperties.getMaxFileSizeMb() + " MB.");
        }
        String extension = extensionOf(file.getOriginalFilename());
        if (!storageProperties.getAllowedExtensions().contains(extension)) {
            throw new FileValidationException("'" + safeFilename(file.getOriginalFilename()) + "' is not an allowed file type. Allowed: "
                    + String.join(", ", storageProperties.getAllowedExtensions()) + ".");
        }
        if (!signatureMatches(file, extension)) {
            throw new FileValidationException("The content of '" + safeFilename(file.getOriginalFilename())
                    + "' does not match its extension.");
        }
        return extension;
    }

    /** Checks the first bytes ("magic number") so a renamed .exe cannot pass as a .pdf. */
    private static boolean signatureMatches(MultipartFile file, String extension) {
        byte[] expected = switch (extension) {
            case "pdf" -> new byte[]{'%', 'P', 'D', 'F'};
            case "png" -> new byte[]{(byte) 0x89, 'P', 'N', 'G'};
            case "jpg", "jpeg" -> new byte[]{(byte) 0xFF, (byte) 0xD8, (byte) 0xFF};
            default -> null; // text-based CAD/CSV formats have no fixed signature
        };
        if (expected == null) {
            return true;
        }
        try (InputStream in = file.getInputStream()) {
            byte[] actual = in.readNBytes(expected.length);
            return Arrays.equals(expected, actual);
        } catch (IOException ex) {
            return false;
        }
    }

    static String extensionOf(String filename) {
        if (filename == null) {
            return "";
        }
        int dot = filename.lastIndexOf('.');
        return dot < 0 ? "" : filename.substring(dot + 1).toLowerCase(Locale.ROOT);
    }

    static String safeFilename(String filename) {
        String name = filename == null || filename.isBlank() ? "file" : filename;
        name = name.replaceAll("[\\\\/:*?\"<>|\\r\\n]", "_");
        return name.length() > 255 ? name.substring(name.length() - 255) : name;
    }
}