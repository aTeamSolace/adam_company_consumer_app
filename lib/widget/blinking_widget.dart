import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  @override
  _BlinkingAnimationState createState() => _BlinkingAnimationState();
}

class _BlinkingAnimationState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  Animation<Color> animationSecond;
  AnimationController controller;

  initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.ease);

    animation =
        ColorTween(begin: Colors.transparent, end: Colors.red).animate(curve);
    animationSecond =
        ColorTween(begin: Colors.transparent, end: Colors.white).animate(curve);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            decoration: BoxDecoration(
              color: animationSecond.value,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10))
            ),
            height: 18,
            child: Text('100% Payment',
                style: TextStyle(color: animation.value, fontSize: 14)),
          );
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
