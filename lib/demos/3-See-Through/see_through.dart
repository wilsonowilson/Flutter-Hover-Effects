// * Unsupported on Flutter web. Check out this issue:
// https://github.com/flutter/flutter/issues/44152

/// Gif by gifer.com
import 'package:flutter/material.dart';

class SeeThrough extends StatefulWidget {
  @override
  _SeeThroughState createState() => _SeeThroughState();
}

class _SeeThroughState extends State<SeeThrough> {
  Offset mousePosition = Offset(0, 0);
  bool hoveringOverText = false;
  @override
  Widget build(BuildContext context) {
    final containerSize = hoveringOverText ? 500.0 : 20.0;
    return Scaffold(
      body: MouseRegion(
        onHover: (e) => setState(() => mousePosition = e.localPosition),
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://i.gifer.com/GpAy.gif'),
                      fit: BoxFit.cover)),
            ),
            SizedBox.expand(
              child: ShaderMask(
                blendMode: BlendMode.srcOut,
                shaderCallback: (bounds) => LinearGradient(
                    colors: [Color.fromARGB(255, 10, 10, 25)],
                    stops: [0.0]).createShader(bounds),
                child: Container(
                  color: Colors.transparent,
                  child: AnimatedOffset(
                    curve: Curves.easeOutCubic,
                    duration: const Duration(milliseconds: 400),
                    offset: Offset(
                      mousePosition.dx - containerSize / 2,
                      mousePosition.dy - containerSize / 2,
                    ),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 300),
                          width: containerSize,
                          height: containerSize,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(containerSize / 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onHover: (e) => setState(() => hoveringOverText = e),
                onTap: () {},
                child: Text(
                  'Jumping Through Portals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedOffset extends ImplicitlyAnimatedWidget {
  AnimatedOffset({
    @required this.curve,
    @required this.duration,
    @required this.offset,
    @required this.child,
  }) : super(curve: curve, duration: duration);

  final Curve curve;
  final Duration duration;
  final Offset offset;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedOffsetState();
}

class _AnimatedOffsetState extends AnimatedWidgetBaseState<AnimatedOffset> {
  Tween<Offset> offsetTween;
  @override
  void forEachTween(visitor) {
    offsetTween = visitor(
        offsetTween, widget.offset, (e) => Tween<Offset>(begin: e as Offset));
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offsetTween?.evaluate(animation) ?? Offset(0, 0),
      child: widget.child,
    );
  }
}
