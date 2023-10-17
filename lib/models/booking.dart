// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Booking {
  String tripTitle = 'no-title';
  String tripDate = 'no-date';

  Booking(this.tripTitle, DateTime tripDate) {
    this.tripDate = DateFormat('kk:mm dd-MM-yyyy').format(tripDate);
  }

  Booking.mapConstructor(this.tripTitle, this.tripDate);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tripTitle': tripTitle,
      'tripDate': tripDate,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking.mapConstructor(
      map['tripTitle'] as String,
      map['tripDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
