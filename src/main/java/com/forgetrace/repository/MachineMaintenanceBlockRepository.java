package com.forgetrace.repository;

import com.forgetrace.entity.MachineMaintenanceBlock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;

public interface MachineMaintenanceBlockRepository extends JpaRepository<MachineMaintenanceBlock, Long> {

    List<MachineMaintenanceBlock> findByMachine_IdOrderByStartAtAsc(Long machineId);

    /** Maintenance blocks that overlap the time range [start, end). */
    @Query("""
            select b from MachineMaintenanceBlock b
            where b.machine.id = :machineId
              and b.startAt < :end
              and b.endAt > :start
            """)
    List<MachineMaintenanceBlock> findOverlapping(@Param("machineId") Long machineId,
                                                  @Param("start") Instant start,
                                                  @Param("end") Instant end);
}