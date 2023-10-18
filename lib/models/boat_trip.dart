import 'dart:ui';

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
  Map<String, dynamic> datesAvalable;

  factory BoatTrip.fromJson(Map<String, dynamic> json) {
    return BoatTrip(
        title: json['title'],
        cardColor: Color(int.parse(json['color'])).withOpacity(1),
        boatAssetName: 'lib/assets/${json['assetName']}.png',
        datesAvalable: json['dates_avalable']);
  }
}
