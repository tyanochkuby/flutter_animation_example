import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_example/presentation/userpage.dart';
import 'package:flutter_animations_example/presentation/widgets/boatcard.dart';
import 'package:flutter_animations_example/presentation/widgets/homesearchbar.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business/bloc/boat_trips_bloc.dart';
import '../models/boat_trip.dart';
import 'authentication/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final scrollController = ScrollController();
  static const double _titleHeight = 177;
  double _top = 0, _topList = _titleHeight;
  double _offsetA = 0, _offsetB = 0, _savedA = 0, _savedB = 0;
  var _tookA = false, _tookB = false, _fadeContainer = true, boatsAdded = false;
  Tween<Offset> offset =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        scrollController.addListener(listener);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Hero(
              tag: 'user-icon',
              transitionOnUserGestures: true,
              child: Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                      onPressed: () async {
                        final userStatus = FirebaseAuth.instance.currentUser;
                        if (userStatus != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      icon: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<BoatTripsBloc, BoatTripsState>(
        builder: (context, state) {
          if (state is BoatTripsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BoatTripsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BoatTripsError) {
            print('Error: ${state.error}');
            // showDialog(
            //     context: context,
            //     builder: ((context) => AlertDialog(
            //           title: Text('Error'),
            //           content: Text(state.error),
            //         )));
          }
          if (state is BoatTripsLoaded) {
            if (!boatsAdded) {
              addBoatCards();
            }
            return Stack(
              children: <Widget>[
                Positioned(
                  top: _topList,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedList(
                      key: context.read<BoatTripsBloc>().state.listKey,
                      controller: scrollController,
                      padding: const EdgeInsets.only(bottom: _titleHeight + 16),
                      initialItemCount: state.boatCards.length,
                      itemBuilder: (_, i, animation) => SlideTransition(
                            position: offset.animate(CurvedAnimation(
                                parent: animation, curve: Curves.easeOutCubic)),
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: i == 0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                    child: state.boatCards.elementAt(i)),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )),
                ),
                Positioned(
                  top: _top,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: _fadeContainer ? 1 + (_top / _titleHeight) : 1,
                    child: Container(
                      height: _titleHeight,
                      color: const Color.fromARGB(210, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const Column(
                        children: [
                          ScreenTitle(title: 'Rent a boat'),
                          SizedBox(
                            height: 20,
                          ),
                          HomeSearchBar(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Unknown BLOC state'));
          }
        },
      ),
    );
  }

  void listener() {
    double offset = scrollController.offset;

    _topList = _titleHeight - offset;
    if (_topList < 0) _topList = 0;

    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _tookB = false;
      if (!_tookA) {
        _tookA = true;
        _offsetA = offset;
      }

      var difference = offset - _offsetA;
      _top = _savedB - difference;
      if (_top <= -_titleHeight) _top = -_titleHeight;
      _savedA = _top;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _tookA = false;
      if (!_tookB) {
        _tookB = true;
        _offsetB = offset;
      }

      var difference = offset - _offsetB;
      _top = _savedA - difference;
      if (_top >= 0) _top = 0;
      _savedB = _top;
    }

    BlocProvider.of<BoatTripsBloc>(context).add(RefreshScrollController());
  }

  Future ft = Future(() {});

  void addBoatCards() async {
    List<BoatTrip> boatTrips = context.read<BoatTripsBloc>().state.boatTrips;

    for (var boatTour in boatTrips) {
      ft = ft.then((_) {
        return Future.delayed(const Duration(milliseconds: 150), () {
          //boatCards.add(BoatCard(boatTour: boatTour));
          BlocProvider.of<BoatTripsBloc>(context)
              .add(BoatCardAdded(BoatCard(boatTour: boatTour)));
          //_listKey.currentState?.insertItem(boatCards.length - 1);
        });
      });

      // await Future.delayed(const Duration(milliseconds: 200));
    }
    boatsAdded = true;
  }
}
