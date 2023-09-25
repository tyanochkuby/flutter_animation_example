import 'package:flutter/material.dart';

class HeartWidget extends StatefulWidget {
  const HeartWidget({super.key});

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> heartColorAnimation;

  late Animation<double> heartSizeAnimation;

  bool isFav = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    heartColorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(controller);

    heartSizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 35, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50, end: 35), weight: 50),
    ]).animate(controller);

    controller.addListener(() {
      print(heartColorAnimation.value);
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: heartColorAnimation,
        builder: (context, _) {
          return Material(
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            color: Colors.transparent,
            clipBehavior: Clip.none,
            type: MaterialType.transparency,
            child: IconButton(
                onPressed: () {
                  isFav ? controller.reverse() : controller.forward();
                },
                icon: Icon(
                  Icons.favorite,
                  color: heartColorAnimation.value,
                  size: heartSizeAnimation.value,
                )),
          );
        });
  }
}
