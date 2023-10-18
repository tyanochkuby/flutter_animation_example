import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/booking.dart';

class BookingsRepository {
  final fireCloud = FirebaseFirestore.instance
      .collection('bookings')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> set(List<Booking> bookingList) async {
    final List<Map> mapedBooking = [];
    bookingList.forEach((element) {
      mapedBooking.add(element.toMap());
    });
    final bookingToSave = <String, dynamic>{
      'bookings': mapedBooking,
    };
    try {
      FirebaseFirestore.instance
          .collection('bookings')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(bookingToSave);
    } on FirebaseAuthException catch (e) {
      print('Auth issue ${e.message}');
    } on FirebaseException catch (e) {
      print('Trip adding failed with error ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Booking>> get() async {
    List<Booking> tripsList = [];
    try {
      final trips =
          await FirebaseFirestore.instance.collection('trips_available').get();

      trips.docs.forEach((trip) {
        tripsList.add(Booking.fromMap(trip.data()));
      });

      return tripsList;
    } on FirebaseAuthException catch (e) {
      print('Auth issue ${e.message}');
      return [];
    } on FirebaseException catch (e) {
      print('Trip adding failed with error ${e.message}');
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
