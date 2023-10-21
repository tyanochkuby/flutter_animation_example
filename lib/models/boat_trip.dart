import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoatTrip {
  BoatTrip({
    required this.title,
    required this.cardColor,
    required this.boatAssetName,
    required this.datesAvalable,
  });

  String title;
  Color cardColor;
  String boatAssetName;
  List<BookingDate> datesAvalable;

  factory BoatTrip.fromJson(Map<String, dynamic> json) {
    return BoatTrip(
        title: json['title'],
        cardColor: Color(int.parse(json['color'])).withOpacity(1),
        boatAssetName: 'lib/assets/${json['assetName']}.png',
        datesAvalable: makeDateList(json['available_dates']));
  }
}

List<BookingDate> makeDateList(Map<String, dynamic> json) {
  List<BookingDate> dates = [];
  json.keys.forEach((key) {
    List<dynamic> times = List.from(json[key]);
    List<TimeOfDay> timesToAdd = [];
    times.forEach((s) {
      timesToAdd.add(TimeOfDay(
          hour: int.parse(s.split(':')[0]),
          minute: int.parse(s.split(':')[1])));
    });

    dates.add(BookingDate(
        date: DateFormat('dd-MM-yyyy').parse(key), times: timesToAdd));
  });
  return dates;
}

class BookingDate {
  BookingDate({
    required this.date,
    required this.times,
  });

  DateTime date;
  List<TimeOfDay> times;
}
