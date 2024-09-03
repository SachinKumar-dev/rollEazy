import 'package:flutter/material.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class TestingAnimations extends StatefulWidget {
  const TestingAnimations({super.key});

  @override
  State<TestingAnimations> createState() => _TestingAnimationsState();
}

class _TestingAnimationsState extends State<TestingAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>? _animation;

  @override
  void initState() {
    //controller duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    //how to animate and position
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    //start the animation
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isAnimate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: _animation!.value * 2 * 3.141592653589793,
            child: Container(
              height: height(context: context, value: 0.3),
              width: width(context: context, value: 0.3),
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
              child: const Text("hi"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (!isAnimate) {
                    isAnimate = true;
                  } else {
                    isAnimate = false;
                  }
                });
              },
              child: const Text("Animate"))
        ],
      ),
    ));
  }
}
