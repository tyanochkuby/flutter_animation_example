import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/homepage.dart';

// ignore: must_be_immutable
class TourDetailsPage extends StatelessWidget {
  TourDetailsPage({super.key, required this.boatTour});

  BoatTour boatTour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            boatTour.title,
            style: const TextStyle(fontSize: 50),
          )
        ],
      ),
    );
  }
}
