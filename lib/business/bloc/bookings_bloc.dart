import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animations_example/business/bloc/boat_trips_bloc.dart';

import '../../data/bookings_repository.dart';
import '../../models/boat_trip.dart';
import '../../models/booking.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingsRepository _bookingsRepository = BookingsRepository();

  BookingsBloc() : super(BookingsInitial()) {
    on<BookingsEventAdd>((event, emit) {});
  }
}
