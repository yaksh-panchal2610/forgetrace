package com.forgetrace.entity;

import com.forgetrace.entity.base.CreatedEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** Metadata about an uploaded file. The file itself is on disk (dev) or in S3 (prod). */
@Entity
@Table(name = "file_objects")
@Getter
@Setter
@NoArgsConstructor
public class FileObject extends CreatedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String bucket;

    @Column(nullable = false, unique = true, length = 500)
    private String objectKey;

    @Column(nullable = false, length = 255)
    private String originalFilename;

    @Column(nullable = false, length = 100)
    private String contentType;

    @Column(nullable = false)
    private Long sizeBytes;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "uploaded_by")
    private User uploadedBy;

    /** Owning organization - used to check who may download the file. */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private Organization organization;
}