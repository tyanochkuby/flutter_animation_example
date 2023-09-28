import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_example/presentation/widgets/boatcard.dart';
import 'package:flutter_animations_example/presentation/widgets/homesearchbar.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';

import '../models/boattour.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<BoatCard> boatCards = [];

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
    scrollController.addListener(listener);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        addBoatCards();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: const Icon(
          Icons.menu_outlined,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _topList,
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedList(
                key: _listKey,
                controller: scrollController,
                padding: const EdgeInsets.only(bottom: _titleHeight + 16),
                initialItemCount: boatCards.length,
                itemBuilder: (_, i, animation) => SlideTransition(
                      position: animation.drive(offset),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.15),
                              child: boatCards.elementAt(i)),
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

    setState(() {});
  }

  void addBoatCards() async {
    if (!boatsAdded) {
      List<BoatTour> boatTours = [
        BoatTour(
            title: 'Lifetime Youth',
            boatAssetName: 'lib/assets/redBoat.png',
            cardColor: const Color.fromARGB(255, 65, 86, 245)),
        BoatTour(
            title: 'Sunny Island',
            boatAssetName: 'lib/assets/redBoat.png',
            cardColor: const Color.fromARGB(255, 255, 171, 215)),
        BoatTour(
            title: 'Pelican Athena',
            boatAssetName: 'lib/assets/redBoat.png',
            cardColor: Color.fromARGB(255, 106, 215, 232)),
        BoatTour(
            title: 'Paliokastritsa',
            boatAssetName: 'lib/assets/redBoat.png',
            cardColor: Color.fromARGB(255, 85, 222, 12))
      ];

      for (var boatTour in boatTours) {
        boatCards.add(BoatCard(boatTour: boatTour));
        _listKey.currentState?.insertItem(boatCards.length - 1);
        // await Future.delayed(const Duration(milliseconds: 200));
      }
      boatsAdded = true;
    }
  }
}
