import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/bookings_repository.dart';
import '../../models/booking.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingsRepository _bookingsRepository = BookingsRepository();

  BookingsBloc() : super(BookingsInitial()) {
    on<BookingsEventGet>((event, emit) async {
      List<Booking> bookingsList = [];
      emit(BookingsLoading());
      try {
        bookingsList = await _bookingsRepository.get();
        emit(BookingsLoaded(bookingsList: bookingsList));
      } on FirebaseException catch (e) {
        emit(BookingsError(error: 'FirebaseException: ${e.toString()}'));
      } catch (e) {
        emit(BookingsError(error: e.toString()));
      }
      emit(BookingsLoaded(bookingsList: bookingsList));
    });
    on<BookingsEventAdd>((event, emit) async {
      emit(BookingsLoading());
      List<Booking> bookingsList = state.bookingsList;
      try {
        bookingsList.add(event.booking);
        await _bookingsRepository.set(bookingsList);
      } on FirebaseException {
        emit(BookingsError(error: 'FirebaseException: ${e.toString()}'));
      } catch (e) {
        emit(BookingsError(error: e.toString()));
      }
      emit(BookingsLoaded(bookingsList: bookingsList));
    });
  }
}
