// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Booking {
  String tripTitle = 'no-title';
  DateTime tripDateTime = DateTime.fromMillisecondsSinceEpoch(0);

  Booking({required this.tripTitle, required this.tripDateTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tripTitle': tripTitle,
      'tripDateTime': DateFormat('dd-MM-yyyy kk:mm').format(tripDateTime),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
        tripTitle: map['tripTitle'],
        tripDateTime: DateTime.parse(map['tripDateTime']));
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
