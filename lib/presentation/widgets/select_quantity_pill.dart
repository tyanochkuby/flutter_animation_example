import 'package:flutter/material.dart';

class SelectQuantityPill extends StatefulWidget {
  const SelectQuantityPill({super.key});

  @override
  State<SelectQuantityPill> createState() => _SelectQuantityPillState();
}

class _SelectQuantityPillState extends State<SelectQuantityPill> {
  static const Color buttonBackgroundColor = Color.fromRGBO(15, 77, 129, 1);
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => i > 0 ? setState(() => i--) : null,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                '1',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => i++),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
