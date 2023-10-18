import 'package:flutter/material.dart';

class BookingTimePicker extends StatefulWidget {
  const BookingTimePicker({super.key});

  @override
  State<BookingTimePicker> createState() => _BookingTimePickerState();
}

class _BookingTimePickerState extends State<BookingTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
    //TODO: Implement
  }

  Widget timePill({required TimeOfDay time, bool active = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active ? Color.fromRGBO(51, 181, 189, 1) : Colors.white,
        border: active ? null : Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(time.format(context)),
      ),
    );
  }
}
