import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/widgets/heart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/boattour.dart';

// ignore: must_be_immutable
class TourDetailsPage extends StatelessWidget {
  TourDetailsPage({super.key, required this.boatTour});

  BoatTour boatTour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: '${boatTour.title}-tour-container',
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                      color: boatTour.cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            boatTour.title,
                            style: GoogleFonts.mulish(
                                color: Colors.white, fontSize: 40),
                          ),
                          HeartWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.4),
                child: Hero(
                  tag: boatTour.boatAssetName,
                  child: Transform.rotate(
                    alignment: Alignment.center,
                    angle: pi / 2,
                    child: Image.asset(
                      'lib/assets/redBoat.png',
                      width: MediaQuery.of(context).size.width * 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
