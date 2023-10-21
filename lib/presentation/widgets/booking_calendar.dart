import 'package:flutter/material.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/src/iterable_extensions.dart';

class Calendar extends StatefulWidget {
  Calendar(this.datesAvailable, this.context) {}

  final List<BookingDate> datesAvailable;
  final BuildContext context;
  DateTime? focusedDay;
  BookingDate? focusedDayBooking;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateTime today = DateTime.now();
  @override
  void initState() {
    widget.focusedDay ??= DateTime(today.year, today.month, today.day);
    widget.focusedDayBooking = widget.datesAvailable
        .firstWhereOrNull((element) => element.date == widget.focusedDay);
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle:
              HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.horizontalSwipe,
          firstDay: today.subtract(Duration(days: today.weekday - 1)),
          lastDay: today.add(const Duration(days: 40)),
          focusedDay: widget.focusedDay!,
          onDaySelected: _onDaySelected,
        ),
        widget.focusedDayBooking == null
            ? const Text('No times available for this day')
            : Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.focusedDayBooking!.times.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(135, 123, 200, 1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        height: 40,
                        width: 120,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            widget.focusedDayBooking!.times[index].toString(),
                          ),
                        ),
                      );
                    }),
              ),
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      widget.focusedDay = selectedDay;
      widget.focusedDayBooking = widget.datesAvailable
          .firstWhereOrNull((element) => element.date == selectedDay);
      print('hi');
    });
  }
}
