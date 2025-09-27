package com.justbook.booking;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.justbook.movie.Movie;
import com.justbook.movie.MovieService;

@Service
@Transactional
public class BookingService {

    private final BookingRepository bookingRepository;
    private final MovieService movieService;

    public BookingService(BookingRepository bookingRepository, MovieService movieService) {
        this.bookingRepository = bookingRepository;
        this.movieService = movieService;
    }

    public Booking createBooking(BookingRequest request) {
        Movie movie = movieService.findById(request.movieId());
        movieService.decreaseSeats(movie, request.seats());
        Booking booking = new Booking(request.customerName(), request.seats(), movie);
        return bookingRepository.save(booking);
    }
}
