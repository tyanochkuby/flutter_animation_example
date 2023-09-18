import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_example/presentation/widgets/boatcard.dart';
import 'package:flutter_animations_example/presentation/widgets/homesearchbar.dart';
import 'package:flutter_animations_example/presentation/widgets/screentitle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/boattour.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  static const double _titleHeight = 170;
  double _top = 0, _topList = _titleHeight;
  double _offsetA = 0, _offsetB = 0, _savedA = 0, _savedB = 0;
  var _tookA = false, _tookB = false, _fadeContainer = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(listener);
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
            child: _buildListView(),
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
                    ScreenTitle(title: 'Rend a boat'),
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
    double offset = _controller.offset;

    _topList = _titleHeight - offset;
    if (_topList < 0) _topList = 0;

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      _tookB = false;
      if (!_tookA) {
        _tookA = true;
        _offsetA = offset;
      }

      var difference = offset - _offsetA;
      _top = _savedB - difference;
      if (_top <= -_titleHeight) _top = -_titleHeight;
      _savedA = _top;
    } else if (_controller.position.userScrollDirection ==
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

  Widget _buildListView() {
    List<BoatTour> boatTours = [
      BoatTour(
          title: 'Lifetime Youth',
          boatAssetName: 'redBoat',
          cardColor: const Color.fromARGB(255, 65, 86, 245)),
      BoatTour(
          title: 'Sunny Island',
          boatAssetName: 'yellowBoat',
          cardColor: const Color.fromARGB(255, 255, 171, 215)),
      BoatTour(
          title: 'Pelican Athena',
          boatAssetName: 'pinkBoat',
          cardColor: Color.fromARGB(255, 106, 215, 232)),
      BoatTour(
          title: 'Paliokastritsa',
          boatAssetName: 'redBoat',
          cardColor: Color.fromARGB(255, 85, 222, 12))
    ];

    return ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.only(bottom: _titleHeight + 16),
        itemCount: boatTours.length,
        itemBuilder: (_, i) => Column(
              children: [
                BoatCard(
                  boatTour: boatTours.elementAt(i),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ));
  }
}
