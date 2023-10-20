import 'package:flutter/material.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  Calendar({required this.datesAvailable});

  final List<BookingDate> datesAvailable;
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        firstDay: today.subtract(Duration(days: today.weekday - 1)),
        lastDay: today.add(const Duration(days: 40)),
        focusedDay: today,
      ),
    );
  }
}
