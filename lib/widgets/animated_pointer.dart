import 'package:flutter/material.dart';

class AnimatedPointer extends StatelessWidget {
  const AnimatedPointer({
    Key key,
    this.movementDuration = const Duration(milliseconds: 700),
    this.radius = 30,
    @required this.pointerOffset,
  }) : super(key: key);
  final Duration movementDuration;
  final Offset pointerOffset;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: movementDuration,
      curve: Curves.easeOutExpo,
      top: pointerOffset.dy,
      left: pointerOffset.dx,
      child: CustomPaint(
        painter: Pointer(radius),
      ),
    );
  }
}

// Multiple containers stacked on top of each other will block pointer
// events, and the blending behaviour of an InkWell is a bit strange, so
// I resorted to using a CustomPainter which doesn't block pointer events.
class Pointer extends CustomPainter {
  final double radius;

  Pointer(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(0, 0),
        radius,
        Paint()
          ..color = Colors.white
          ..blendMode = BlendMode.difference);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
