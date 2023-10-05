import 'package:flutter/material.dart';

class TextFieldBoatBound extends StatelessWidget {
  const TextFieldBoatBound(
      {super.key,
      required this.controller,
      this.labelText,
      this.isHiden = false});

  final TextEditingController controller;
  final String? labelText;
  final bool isHiden;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      obscureText: isHiden,
    );
  }
}
