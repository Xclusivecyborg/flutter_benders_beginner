import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimationsExample extends StatefulWidget {
  const ImplicitAnimationsExample({super.key});

  @override
  State<ImplicitAnimationsExample> createState() =>
      _ImplicitAnimationsExampleState();
}

class _ImplicitAnimationsExampleState extends State<ImplicitAnimationsExample>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tap to drop down'),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _isVisible ? 0.25 : 0,
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: Tween<double>(begin: 0, end: 1)
                      .chain(CurveTween(curve: Curves.bounceIn))
                      .animate(animation),
                  child: RotationTransition(
                    turns: animation,
                    child: child,
                  ),
                );
              },
              child: _isVisible
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(),
                          right: BorderSide(),
                          left: BorderSide(),
                        ),
                      ),
                      child: const FlutterLogo(size: 200),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}



