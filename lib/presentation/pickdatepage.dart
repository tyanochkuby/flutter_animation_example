import 'package:flutter/material.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';
import 'package:flutter_animations_example/presentation/widgets/booking_calendar.dart';

class PickDatePage extends StatelessWidget {
  const PickDatePage({required this.boatTrip});

  final BoatTrip boatTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a date for ${boatTrip.title}'),
      ),
      body: Column(
        children: [
          Calendar(
            datesAvailable: boatTrip.datesAvalable,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
