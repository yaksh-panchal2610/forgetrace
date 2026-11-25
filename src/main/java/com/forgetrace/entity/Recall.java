package com.forgetrace.entity;

import com.forgetrace.entity.base.AuditableEntity;
import com.forgetrace.enums.RecallSeverity;
import com.forgetrace.enums.RecallStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "recalls")
@Getter
@Setter
@NoArgsConstructor
public class Recall extends AuditableEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "batch_id")
    private Batch batch;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "initiated_by")
    private User initiatedBy;

    @Column(nullable = false, columnDefinition = "text")
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private RecallSeverity severity;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private RecallStatus status = RecallStatus.INITIATED;

    @OneToMany(mappedBy = "recall", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RecallRecipient> recipients = new ArrayList<>();

    public void addRecipient(RecallRecipient recipient) {
        recipient.setRecall(this);
        recipients.add(recipient);
    }
}