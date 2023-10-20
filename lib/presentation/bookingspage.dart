import 'package:flutter/material.dart';
import 'package:flutter_animations_example/business/bloc/bookings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/booking.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: Center(
        child:
            BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
          if (state is BookingsLoading || state is BookingsInitial) {
            return const CircularProgressIndicator();
          }
          if (state is BookingsError) {
            return Text(state.error);
          }
          if (state is BookingsLoaded) {
            return ListView.builder(
                itemCount: state.bookingsList.length,
                itemBuilder: (context, index) {
                  return bookingTile(state.bookingsList[index]);
                });
          } else {
            return const Text('Unknown state');
          }
        }),
      ),
    );
  }

  Widget bookingTile(Booking booking) {
    return GestureDetector(
      child: ListTile(
        title: Text(booking.tripTitle),
        subtitle: Text(booking.tripDate),
      ),
    );
  }
}
