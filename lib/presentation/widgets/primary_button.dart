import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, this.onPressed, this.text});

  final void Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(15, 77, 129, 0.8),
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        onPressed: onPressed,
        child: text != null
            ? Text(
                text!,
                style: TextStyle(fontSize: 26),
              )
            : const Text(''));
  }
}
