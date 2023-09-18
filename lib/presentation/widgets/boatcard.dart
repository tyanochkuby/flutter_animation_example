import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/boattour.dart';
import '../detailspage.dart';

class BoatCard extends StatelessWidget {
  const BoatCard({super.key, required this.boatTour});

  final BoatTour boatTour;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height / 6,
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
                  builder: (context) => TourDetailsPage(
                    boatTour: boatTour,
                  ),
                ),
              ),
              child: Hero(
                tag: '${boatTour.title}-tour-container',
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
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35),
            child: Hero(
              tag: boatTour.boatAssetName,
              child: Image.asset(
                boatTour.boatAssetName,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
