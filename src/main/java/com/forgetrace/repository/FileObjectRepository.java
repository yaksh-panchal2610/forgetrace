package com.forgetrace.repository;

import com.forgetrace.entity.FileObject;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FileObjectRepository extends JpaRepository<FileObject, Long> {

    Optional<FileObject> findByObjectKey(String objectKey);
}