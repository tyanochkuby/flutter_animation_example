import 'package:flutter/material.dart';

class HeartWidget extends StatefulWidget {
  const HeartWidget({super.key});

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation heartColorAnimation;
  late Animation<double> curveAnimation;
  late Animation heartSizeAnimation;

  bool isFav = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    curveAnimation =
        CurvedAnimation(parent: controller, curve: Curves.slowMiddle);

    heartColorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(curveAnimation);

    heartSizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 35, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50, end: 35), weight: 50),
    ]).animate(curveAnimation);

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
