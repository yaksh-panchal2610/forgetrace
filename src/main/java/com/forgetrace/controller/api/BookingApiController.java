package com.forgetrace.controller.api;

import com.forgetrace.dto.request.BookingRequest;
import com.forgetrace.service.BookingService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * JSON booking API. Example body for POST /api/bookings:
 * {"orderId": 1, "machineId": 2, "startAt": "2026-12-01T09:00", "endAt": "2026-12-01T17:00"}
 */
@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class BookingApiController {

    private final BookingService bookingService;

    @PostMapping("/bookings")
    @ResponseStatus(HttpStatus.CREATED)
    public BookingService.ReservationView book(@Valid @RequestBody BookingRequest request) {
        return bookingService.book(request);
    }

    @GetMapping("/orders/{orderId}/bookings")
    public List<BookingService.ReservationView> forOrder(@PathVariable Long orderId) {
        return bookingService.reservationsForOrder(orderId);
    }
}