import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 700),
        builder: (context, tweenValue, child) {
          return Opacity(
            opacity: tweenValue,
            child: Padding(
              padding: EdgeInsets.only(top: (tweenValue * 50)),
              child: child,
            ),
          );
        },
        child: Text(
          title,
          style: GoogleFonts.rajdhani(
              textStyle: const TextStyle(fontSize: 40, color: Colors.black)),
        ));
  }
}
