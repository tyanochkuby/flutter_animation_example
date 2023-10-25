import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'bookingspage.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              },
              child: const Text('Logout')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BookingsPage())),
              child: const Text('My Bookings')),
        ],
      )),
    );
  }
}
