package com.justbook.booking;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record BookingRequest(
        @NotBlank String customerName,
        @NotNull Long movieId,
        @Min(1) int seats
) {
}
