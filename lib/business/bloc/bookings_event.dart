part of 'bookings_bloc.dart';

sealed class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class BookingsEventGet extends BookingsEvent {}

class BookingsEventAdd extends BookingsEvent {
  const BookingsEventAdd({required this.booking});

  final Booking booking;

  @override
  List<Object> get props => [booking];
}
