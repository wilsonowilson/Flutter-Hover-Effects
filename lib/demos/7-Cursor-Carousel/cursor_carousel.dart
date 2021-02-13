import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const images = <String>[
  'https://images.unsplash.com/photo-1582201957623-f8e797c5d8aa?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1053&q=80',
  'https://images.unsplash.com/photo-1577720580216-048a2a2395b2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=840&q=80',
  'https://images.unsplash.com/photo-1584285405368-5cec784a5025?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1577720580479-7d839d829c73?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=976&q=80',
  'https://images.unsplash.com/photo-1580711465053-6757198851cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1054&q=80',
  'https://images.unsplash.com/photo-1549277513-f1b32fe1f8f5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1050&q=80',
  'https://images.unsplash.com/photo-1578301978961-a526d6fb0d54?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=720&q=80',
  'https://images.unsplash.com/flagged/photo-1572392640988-ba48d1a74457?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=700&q=80',
  'https://images.unsplash.com/photo-1582201957424-621320ad670d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1511&q=80',
  'https://images.unsplash.com/photo-1580711465053-6757198851cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1054&q=80',
];

class CursorCarousel extends StatelessWidget {
  final pageController = PageController(
    viewportFraction: 0.6,
    initialPage: 10000,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Interesting Art...',
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    'Hover to navigate',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 10,
            child: CursorRegion(
              pageController: pageController,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  final image = images[index % images.length];
                  return Container(
                    height: 500,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class CursorRegion extends StatefulWidget {
  final PageController pageController;
  final Widget child;
  const CursorRegion({
    Key key,
    @required this.pageController,
    @required this.child,
  }) : super(key: key);

  @override
  _CursorRegionState createState() => _CursorRegionState();
}

class _CursorRegionState extends State<CursorRegion> {
  Offset _pointerOffset = Offset(0, 0);
  bool isHovering = false;
  HorizontalPosition _pointerDirection = HorizontalPosition.right;
  final _pageSwitchDuration = Duration(milliseconds: 400);
  final _pageSwitchCurve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onExit: (_) => setState(() => isHovering = false),
      onEnter: (_) => setState(() => isHovering = true),
      onHover: (e) {
        final size = MediaQuery.of(context).size;

        _pointerOffset = e.localPosition;
        final pointerDirection = _pointerOffset.dx <= size.width / 2
            ? HorizontalPosition.left
            : HorizontalPosition.right;

        this._pointerDirection = pointerDirection;
        setState(() {});
      },
      child: Stack(
        children: [
          SizedBox.expand(child: widget.child),
          AnimatedPositioned(
            duration: Duration(milliseconds: 450),
            top: _pointerOffset?.dy ?? 0,
            left: _pointerOffset?.dx ?? 0,
            curve: Curves.easeOutExpo,
            child: AnimatedOpacity(
              opacity: isHovering ? 1 : 0,
              duration: Duration(milliseconds: 600),
              child: AnimatedPointer(
                isHovering: isHovering,
                direction: _pointerDirection,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.pageController.previousPage(
                      duration: _pageSwitchDuration,
                      curve: _pageSwitchCurve,
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.pageController.nextPage(
                      duration: _pageSwitchDuration,
                      curve: _pageSwitchCurve,
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum HorizontalPosition { left, right }
enum VerticalPosition { top, bottom }

class AnimatedPointer extends StatelessWidget {
  const AnimatedPointer({
    Key key,
    @required this.direction,
    @required this.isHovering,
  }) : super(key: key);

  final HorizontalPosition direction;
  final bool isHovering;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-75, -75),
      child: AnimatedRotate(
        rotation: isHovering
            ? direction == HorizontalPosition.left
                ? -pi
                : 0
            : direction == HorizontalPosition.left
                ? -pi * 2
                : pi,
        curve: isHovering ? Curves.easeInOutQuart : Curves.easeOut,
        duration: Duration(milliseconds: 600),
        child: AnimatedContainer(
          width: isHovering ? 150 : 0,
          height: isHovering ? 150 : 0,
          duration: Duration(milliseconds: 600),
          child: IgnorePointer(
            // behavior: HitTestBehavior.translucent,
            child: Image.network(
              'https://www.pngkey.com/png/full/44-440125_right-arrow-outlined-png-svg-clip-art-for.png',
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedRotate extends ImplicitlyAnimatedWidget {
  AnimatedRotate({
    @required this.child,
    @required this.rotation,
    @required Duration duration,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve);
  final Widget child;
  final double rotation;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      AnimatedRotateState();
}

class AnimatedRotateState extends AnimatedWidgetBaseState<AnimatedRotate> {
  Tween<double> _rotation;
  @override
  void forEachTween(visitor) {
    _rotation = visitor(
      _rotation,
      widget.rotation,
      (value) => Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _rotation?.evaluate(animation) ?? 0,
      child: widget.child,
    );
  }
}
