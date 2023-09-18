import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_example/presentation/widgets/boatcard.dart';
import 'package:flutter_animations_example/presentation/widgets/homesearchbar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  static const double _titleHeight = 150;
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
        backgroundColor: Colors.white,
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
            top: _top,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: _fadeContainer ? 1 + (_top / _titleHeight) : 1,
              child: Container(
                height: _titleHeight,
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Rent a boat',
                      style: GoogleFonts.rajdhani(
                          textStyle: const TextStyle(
                              fontSize: 40, color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const HomeSearchBar(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: _topList,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildListView(),
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
      BoatTour(title: 'Lifetime Youth', boatAssetName: 'redBoat'),
      BoatTour(title: 'Sunny Island', boatAssetName: 'yellowBoat'),
      BoatTour(title: 'Pelican Athena', boatAssetName: 'pinkBoat')
    ];

    return ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.only(bottom: _titleHeight + 16),
        itemCount: boatTours.length,
        itemBuilder: (_, i) => BoatCard(
            title: boatTours.elementAt(i).title,
            boatAssetName: boatTours.elementAt(i).boatAssetName));
  }
}

class BoatTour {
  BoatTour({required this.title, required this.boatAssetName});

  String title;
  String boatAssetName;
}
