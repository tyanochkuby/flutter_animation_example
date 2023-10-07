import 'package:flutter/material.dart';

class TextFormFieldBoatBound extends StatelessWidget {
  const TextFormFieldBoatBound(
      {super.key,
      required this.controller,
      this.labelText,
      this.isHiden = false,
      this.validator,
      this.autovalidateMode,
      this.formKey});

  final TextEditingController controller;
  final String? labelText;
  final bool isHiden;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      autovalidateMode: autovalidateMode,
      validator: validator,
      obscureText: isHiden,
    );
  }
}
