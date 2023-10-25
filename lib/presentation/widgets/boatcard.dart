import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../../models/boat_trip.dart';
import '../detailspage.dart';

class BoatCard extends StatelessWidget {
  const BoatCard({super.key, required this.boatTour});

  final BoatTrip boatTour;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TourDetailsPage(boatTrip: boatTour)),
              ),
              child: Hero(
                tag: '${boatTour.title}-tour-container',
                transitionOnUserGestures: true,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.36,
                  decoration: BoxDecoration(
                      color: boatTour.cardColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                        bottom: MediaQuery.of(context).size.width * 0.03),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        boatTour.title,
                        style: GoogleFonts.mulish(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.22,
                top: MediaQuery.of(context).size.width * 0.05),
            child: Hero(
              tag: '${boatTour.boatAssetName}-${boatTour.title}',
              transitionOnUserGestures: true,
              flightShuttleBuilder:
                  (_, Animation<double> animation, __, ___, ____) {
                final customAnimation = Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutCubic));
                return AnimatedBuilder(
                    animation: customAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle:
                            (pi / 4.5 + (customAnimation.value * 2.5 * pi / 9)),
                        child: Image.asset(
                          boatTour.boatAssetName,
                          width: MediaQuery.of(context).size.width * 0.6 +
                              1.4 * customAnimation.value,
                        ),
                      );
                    });
              },
              child: Transform.rotate(
                angle: pi / 4.5,
                child: Image.asset(
                  boatTour.boatAssetName,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
