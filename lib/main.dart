import 'package:flutter/material.dart';
import 'package:flutter_animations_example/business/bloc/boat_trips_bloc.dart';
import 'package:flutter_animations_example/business/bloc/bookings_bloc.dart';
import 'package:flutter_animations_example/presentation/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BoatTripsBloc>(
          create: (context) => BoatTripsBloc()..add(GetData()),
        ),
        BlocProvider<BookingsBloc>(
          create: (context) => BookingsBloc()..add(BookingsEventGet()),
        )
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: HomePage()),
    );
  }
}
