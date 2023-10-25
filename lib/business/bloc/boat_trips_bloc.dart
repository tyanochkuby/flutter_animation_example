import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/widgets/boatcard.dart';
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
          emit(BoatTripsLoaded(
              boatTrips: boatTrips,
              listKey: GlobalKey<AnimatedListState>(),
              boatCards: []));
        } catch (e) {
          emit(BoatTripsError(error: e.toString()));
        }
      },
    );
    on<RefreshScrollController>(
      ((event, emit) => emit(BoatTripsLoaded(
          boatTrips: state.boatTrips,
          listKey: state.listKey,
          boatCards: state.boatCards))),
    );
    on<BoatCardAdded>(
      (event, emit) {
        var res = state.boatCards;
        res.add(event.boatCard);
        state.listKey.currentState!.insertItem(state.boatCards.length - 1);
        emit(BoatTripsLoaded(
            boatTrips: state.boatTrips,
            listKey: state.listKey,
            boatCards: state.boatCards));
      },
    );
  }
}
