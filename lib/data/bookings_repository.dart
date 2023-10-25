import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/booking.dart';

class BookingsRepository {
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
    List<Booking> bookingsList = [];
    try {
      final bookings = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // bookings.forEach((booking) {
      //   bookingsList.add(Booking.fromMap(booking.data()));
      // });

      return bookingsList;
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
