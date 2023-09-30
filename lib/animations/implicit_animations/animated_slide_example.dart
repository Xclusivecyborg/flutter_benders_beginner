import 'package:flutter/material.dart';

class AniimatedSlide extends StatefulWidget {
  const AniimatedSlide({super.key});

  @override
  State<AniimatedSlide> createState() => _AniimatedSlideState();
}

class _AniimatedSlideState extends State<AniimatedSlide>
    with SingleTickerProviderStateMixin {
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedSlide(
            offset: offset,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          Slider(
            value: offset.dx,
            onChanged: (v) {
              setState(() {
                offset = Offset(v, offset.dy);
              });
            },
          ),
        ],
      ),
    );
  }
}
