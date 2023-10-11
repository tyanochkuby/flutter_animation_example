import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';
import 'package:flutter_animations_example/data/trips_repository.dart';

part 'boat_trips_event.dart';
part 'boat_trips_state.dart';

class BoatTripsBloc extends Bloc<BoatTripsEvent, BoatTripsState> {
  final TripsRepository _boatTripsRepository = TripsRepository();
  BoatTripsBloc() : super(BoatTripsInitial()) {
    on<GetData>(
      (event, emit) async {
        emit(BoatTripsLoading());
        try {
          List<BoatTrip> boatTrips = await _boatTripsRepository.get();
          emit(BoatTripsLoaded(boatTrips: boatTrips));
        } catch (e) {
          emit(BoatTripsError(error: e.toString()));
        }
      },
    );
  }
}
