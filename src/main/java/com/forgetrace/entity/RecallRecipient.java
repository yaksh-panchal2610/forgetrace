package com.forgetrace.entity;

import com.forgetrace.enums.AcknowledgementStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Entity
@Table(name = "recall_recipients")
@Getter
@Setter
@NoArgsConstructor
public class RecallRecipient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "recall_id")
    private Recall recall;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "organization_id")
    private Organization organization;

    private Instant notifiedAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private AcknowledgementStatus acknowledgementStatus = AcknowledgementStatus.PENDING;

    private Instant acknowledgedAt;
}