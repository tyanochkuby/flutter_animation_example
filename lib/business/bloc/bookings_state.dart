part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  BookingsState({required this.bookingsList});

  final List<Booking> bookingsList;

  @override
  List<Object> get props => [];
}

final class BookingsInitial extends BookingsState {
  BookingsInitial() : super(bookingsList: []);

  @override
  List<Object> get props => [];
}

class BookingsError extends BookingsState {
  final String error;

  BookingsError({required this.error}) : super(bookingsList: []);

  @override
  List<Object> get props => [error];
}

class BookingsLoading extends BookingsState {
  BookingsLoading() : super(bookingsList: []);

  @override
  List<Object> get props => [];
}

class BookingsLoaded extends BookingsState {
  BookingsLoaded({required List<Booking> super.bookingsList});

  @override
  List<Object> get props => [bookingsList];
}
