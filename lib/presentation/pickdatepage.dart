import 'package:flutter/material.dart';
import 'package:flutter_animations_example/presentation/widgets/booking_calendar.dart';

class PickDatePage extends StatelessWidget {
  const PickDatePage({required this.bookingTitle});

  final String bookingTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a date for $bookingTitle'),
      ),
      body: Column(
        children: [
          Calendar(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
