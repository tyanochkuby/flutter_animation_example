part of 'boat_trips_bloc.dart';

@immutable
sealed class BoatTripsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetData extends BoatTripsEvent {
  GetData();
}
