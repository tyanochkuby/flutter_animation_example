import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile(
      {super.key, this.color = Colors.white, this.onTap, this.child});

  final Color color;
  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: child,
      ),
    );
  }
}
