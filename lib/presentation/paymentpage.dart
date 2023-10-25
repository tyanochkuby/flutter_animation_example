import 'package:flutter/material.dart';
import 'package:flutter_animations_example/business/bloc/bookings_bloc.dart';
import 'package:flutter_animations_example/models/booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your trip to ${booking.tripTitle}'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Your trip to ${booking.tripTitle} is booked for ${booking.tripDateTime.day}-${booking.tripDateTime.month}-${booking.tripDateTime.year} at ${booking.tripDateTime.hour}:${booking.tripDateTime.minute}',
              style: const TextStyle(
                fontSize: 24.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
                color: const Color.fromRGBO(
                    15, 77, 129, 0.8), // Customize the text color
                letterSpacing: 1.5, // Adjust the letter spacing as needed
                fontFamily: 'Pacifico', // Use the 'Pacifico' font
              ),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          const Text('Please pay ??? USD'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<BookingsBloc>(context)
                  .add(BookingsEventAdd(booking: booking));
            },
            child: const Text('Pay'),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
