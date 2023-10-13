part of 'boat_trips_bloc.dart';

@immutable
sealed class BoatTripsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetData extends BoatTripsEvent {
  GetData();
}

class RefreshScrollController extends BoatTripsEvent {
  RefreshScrollController();
}

class BoatCardAdded extends BoatTripsEvent {
  final BoatCard boatCard;
  BoatCardAdded(this.boatCard);
}
