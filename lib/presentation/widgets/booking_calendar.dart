import 'package:flutter/material.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';
import 'package:flutter_animations_example/models/booking.dart';
import 'package:flutter_animations_example/presentation/widgets/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/src/iterable_extensions.dart';

import '../paymentpage.dart';

class Calendar extends StatefulWidget {
  Calendar({required this.boatTrip, required this.context});

  final BoatTrip boatTrip;
  late List<BookingDate> datesAvailable = boatTrip.datesAvalable;
  final BuildContext context;
  DateTime? focusedDay;
  BookingDate? focusedDayBooking;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateTime today = DateTime.now();
  Booking? selectedBooking;

  @override
  Widget build(BuildContext context) {
    widget.focusedDay ??= DateTime(today.year, today.month, today.day);
    for (var i = 0; i < widget.datesAvailable.length; i++) {
      if ("${widget.datesAvailable[i].date.toString()}Z" ==
          widget.focusedDay.toString()) {
        widget.focusedDayBooking = widget.datesAvailable[i];
      }
    }
    print('initState');
    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
              formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.horizontalSwipe,
          firstDay: today.subtract(Duration(days: today.weekday - 1)),
          lastDay: today.add(const Duration(days: 40)),
          focusedDay: widget.focusedDay!,
          selectedDayPredicate: (day) => isSameDay(widget.focusedDay!, day),
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(
          height: 20,
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
                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedBooking = Booking(
                              tripTitle: widget.boatTrip.title,
                              tripDateTime: DateTime(
                                widget.focusedDay!.year,
                                widget.focusedDay!.month,
                                widget.focusedDay!.day,
                                widget.focusedDayBooking!.times[index].hour,
                                widget.focusedDayBooking!.times[index].minute,
                              ));
                        }),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(135, 123, 200, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 70,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  "${widget.focusedDayBooking!.times[index].hour}:${widget.focusedDayBooking!.times[index].minute == 0 ? '00' : widget.focusedDayBooking!.times[index].minute}"),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        Spacer(
          flex: 5,
        ),
        selectedBooking != null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                  text: 'Go to payment',
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PaymentPage(
                                booking: selectedBooking!,
                              )))),
                ),
              )
            : Container(),
        Spacer(
          flex: 1,
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
