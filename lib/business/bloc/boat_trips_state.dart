part of 'boat_trips_bloc.dart';

abstract class BoatTripsState {
  BoatTripsState({required this.boatTrips});
  List<Object?> get props => [];

  final List<BoatTrip> boatTrips;
}

class BoatTripsInitial extends BoatTripsState {
  BoatTripsInitial() : super(boatTrips: []);
  @override
  List<Object?> get props => [];
}

class BoatTripsError extends BoatTripsState {
  final String error;

  BoatTripsError({required this.error}) : super(boatTrips: []);
  @override
  List<Object?> get props => [error];
}

class BoatTripsLoading extends BoatTripsState {
  BoatTripsLoading() : super(boatTrips: []);
  @override
  List<Object?> get props => [];
}

class BoatTripsLoaded extends BoatTripsState {
  BoatTripsLoaded({required List<BoatTrip> this.boatTrips})
      : super(boatTrips: boatTrips);

  List<BoatTrip> boatTrips;
  @override
  List<Object?> get props => [boatTrips];
}
