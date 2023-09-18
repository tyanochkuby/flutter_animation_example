import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoatCard extends StatelessWidget {
  const BoatCard({super.key, required this.title, required this.boatAssetName});

  final String title;
  final String boatAssetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style:
                        GoogleFonts.mulish(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35),
            child: Image.asset(boatAssetName),
          )
        ],
      ),
    );
  }
}
