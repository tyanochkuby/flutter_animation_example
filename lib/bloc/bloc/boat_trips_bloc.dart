import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_animations_example/models/boattour.dart';

part 'boat_trips_event.dart';
part 'boat_trips_state.dart';

class BoatTripsBloc extends Bloc<BoatTripsEvent, BoatTripsState> {
  BoatTripsBloc() : super(BoatTripsState(boatTrips: []));
}
