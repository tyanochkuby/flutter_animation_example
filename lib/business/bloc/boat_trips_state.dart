part of 'boat_trips_bloc.dart';

abstract class BoatTripsState {
  BoatTripsState(
      {required this.boatTrips,
      required this.listKey,
      required this.boatCards});
  List<Object?> get props => [];

  final List<BoatTrip> boatTrips;
  final GlobalKey<AnimatedListState> listKey;
  final List<BoatCard> boatCards;
}

class BoatTripsInitial extends BoatTripsState {
  BoatTripsInitial()
      : super(
            boatTrips: [],
            listKey: GlobalKey<AnimatedListState>(),
            boatCards: []);
  @override
  List<Object?> get props => [];
}

class BoatTripsError extends BoatTripsState {
  final String error;

  BoatTripsError({required this.error})
      : super(
            boatTrips: [],
            listKey: GlobalKey<AnimatedListState>(),
            boatCards: []);
  @override
  List<Object?> get props => [error];
}

class BoatTripsLoading extends BoatTripsState {
  BoatTripsLoading()
      : super(
            boatTrips: [],
            listKey: GlobalKey<AnimatedListState>(),
            boatCards: []);
  @override
  List<Object?> get props => [];
}

class BoatTripsLoaded extends BoatTripsState {
  BoatTripsLoaded(
      {required List<BoatTrip> this.boatTrips,
      required this.listKey,
      required this.boatCards})
      : super(boatTrips: boatTrips, listKey: listKey, boatCards: boatCards);

  List<BoatTrip> boatTrips;
  GlobalKey<AnimatedListState> listKey;
  List<BoatCard> boatCards;
  @override
  List<Object?> get props => [boatTrips, listKey, boatCards];
}
