package com.forgetrace.service;

import com.forgetrace.dto.request.ContactForm;
import com.forgetrace.entity.ContactRequest;
import com.forgetrace.repository.ContactRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;

@Service
@RequiredArgsConstructor
public class ContactService {

    private final ContactRequestRepository contactRequestRepository;
    private final AuditService auditService;

    @Transactional
    public void submit(ContactForm form) {
        ContactRequest request = new ContactRequest();
        request.setName(form.getName().trim());
        request.setEmail(form.getEmail().trim().toLowerCase(Locale.ROOT));
        request.setSubject(form.getSubject().trim());
        request.setMessage(form.getMessage().trim());
        contactRequestRepository.save(request);

        auditService.record(null, "CONTACT_REQUEST", "ContactRequest", request.getId(), request.getSubject());
    }
}