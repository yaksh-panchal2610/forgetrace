package com.forgetrace.repository;

import com.forgetrace.entity.MachineReservation;
import com.forgetrace.enums.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;

public interface MachineReservationRepository extends JpaRepository<MachineReservation, Long> {

    List<MachineReservation> findByProductionOrder_Id(Long productionOrderId);

    List<MachineReservation> findByMachine_IdAndStatusOrderByStartAtAsc(Long machineId, ReservationStatus status);

    /** Reservations with the given status that overlap [start, end). Used before booking. */
    @Query("""
            select r from MachineReservation r
            where r.machine.id = :machineId
              and r.status = :status
              and r.startAt < :end
              and r.endAt > :start
            """)
    List<MachineReservation> findOverlapping(@Param("machineId") Long machineId,
                                             @Param("status") ReservationStatus status,
                                             @Param("start") Instant start,
                                             @Param("end") Instant end);
}