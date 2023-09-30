import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedALignExample extends StatefulWidget {
  const AnimatedALignExample({super.key});

  @override
  State<AnimatedALignExample> createState() => _AnimatedALignExampleState();
}

class _AnimatedALignExampleState extends State<AnimatedALignExample>
    with SingleTickerProviderStateMixin {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  bool visible = false;

  Alignment _getRandomAlignment() {
    //get random values between -1.0 and 1.0
    final x = Random().nextDouble() * 2 - 1;
    final y = Random().nextDouble() * 2 - 1;

    return Alignment(x, y);
  }

  Color _getRandomColor() {
    //get random values between 0 and 255
    final r = Random().nextInt(256);
    final g = Random().nextInt(256);
    final b = Random().nextInt(256);

    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: AnimatedAlign(
        alignment: _getRandomAlignment(),
        duration: const Duration(seconds: 1),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: 100,
          height: 100,
          color: _getRandomColor(),
        ),
      ),
    );
  }
}
