import 'dart:ui';

class BoatTrip {
  BoatTrip(
      {required this.title,
      required this.cardColor,
      required this.boatAssetName});

  String title;
  Color cardColor;
  String boatAssetName;

  factory BoatTrip.fromJson(Map<String, dynamic> json) {
    return BoatTrip(
        title: json['title'],
        cardColor: json['color'],
        boatAssetName: json['assetName']);
  }
}
