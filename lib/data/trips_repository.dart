import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animations_example/models/boat_trip.dart';

class TripsRepository {
  final fireCloud = FirebaseFirestore.instance.collection('trips_available');

  Future<void> addTrip(Map<String, dynamic> trip) async {
    try {
      await fireCloud.add(trip);
    } on FirebaseException catch (e) {
      print('Trip adding failed with error ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<BoatTrip>> get() async {
    List<BoatTrip> tripsList = [];
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('trips_available').get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var trip in allData) {
        tripsList.add(BoatTrip.fromJson(trip));
      }

      return tripsList;
    } on FirebaseException catch (e) {
      print('Geting failed with error ${e.message}');
      return tripsList;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
