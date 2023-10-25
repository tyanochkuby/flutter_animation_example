import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/pickdatepage.dart';
import 'package:flutter_animations_example/presentation/widgets/heart.dart';
import 'package:flutter_animations_example/presentation/widgets/primary_button.dart';
import 'package:flutter_animations_example/presentation/widgets/select_quantity_pill.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/boat_trip.dart';

// ignore: must_be_immutable
class TourDetailsPage extends StatelessWidget {
  TourDetailsPage({super.key, required this.boatTrip});

  final BoatTrip boatTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: '${boatTrip.title}-tour-container',
                transitionOnUserGestures: true,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                      color: boatTrip.cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    boatTrip.title,
                                    style: GoogleFonts.mulish(
                                        color: Colors.white, fontSize: 40),
                                  ),
                                  const HeartWidget(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SelectQuantityPill(),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              text: 'Book Now',
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => PickDatePage(
                                            boatTrip: boatTrip,
                                          )))),
                            ),
                          ],
                        ),
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
                  tag: '${boatTrip.boatAssetName}-${boatTrip.title}',
                  transitionOnUserGestures: true,
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
