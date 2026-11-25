package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.RfqStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnTransformer;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

@Entity
@Table(name = "rfqs")
@Getter
@Setter
@NoArgsConstructor
public class Rfq extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 30)
    private String rfqNumber;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "buyer_organization_id")
    private Organization buyerOrganization;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Column(nullable = false, length = 160)
    private String title;

    @Column(columnDefinition = "text")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "process_id")
    private ManufacturingProcess process;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "material_id")
    private Material material;

    @Column(nullable = false, precision = 14, scale = 3)
    private BigDecimal quantity;

    @Column(nullable = false, length = 20)
    private String quantityUnit = "pcs";

    /** Flexible technical specs stored as JSON text, e.g. {"thickness":"2mm","finish":"powder coat"} */
    @Column(columnDefinition = "jsonb")
    @ColumnTransformer(write = "?::jsonb")
    private String specifications;

    @Column(columnDefinition = "text")
    private String toleranceNotes;

    @Column(nullable = false)
    private LocalDate deliveryDate;

    @Column(nullable = false, columnDefinition = "text")
    private String deliveryAddress;

    @Column(nullable = false)
    private Instant quoteDeadline;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private RfqStatus status = RfqStatus.OPEN;

    public boolean isOpenFor(Instant now) {
        return status.isAcceptingQuotes() && quoteDeadline.isAfter(now);
    }
}