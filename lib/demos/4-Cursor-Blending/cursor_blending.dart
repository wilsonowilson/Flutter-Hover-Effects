// # INSPIRED BY: https://codepen.io/clementGir/pen/RQqvQx

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../widgets/animated_pointer.dart';

class CursorBlending extends StatefulWidget {
  @override
  _CursorBlendingState createState() => _CursorBlendingState();
}

class _CursorBlendingState extends State<CursorBlending>
    with SingleTickerProviderStateMixin {
  Offset pointerOffset = Offset(0, 0);
  AnimationController pointerSizeController;
  Animation<double> pointerAnimation;
  @override
  void initState() {
    pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent: Tween<double>(begin: 0, end: 1).animate(pointerSizeController));
    super.initState();
  }

  void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController.forward();
    } else
      pointerSizeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.none,
        onHover: (e) => setState(() => pointerOffset = e.localPosition),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextColumn(
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onLinkHovered: togglePointerSize,
                  ),
                ),
                Expanded(
                  child: TextColumn(
                    onLinkHovered: togglePointerSize,
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
                animation: pointerSizeController,
                builder: (context, snapshot) {
                  return AnimatedPointer(
                    pointerOffset: pointerOffset,
                    radius: 45 + 100 * pointerAnimation.value,
                  );
                }),
            // }),
            AnimatedPointer(
              pointerOffset: pointerOffset,
              movementDuration: const Duration(milliseconds: 200),
              radius: 10,
            )
          ],
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    Key key,
    @required this.onLinkHovered,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Function(bool) onLinkHovered;
  final Color textColor;
  final Color backgroundColor;

  TextStyle get _defaultTextStyle => TextStyle(color: textColor);
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Hello',
            style: _defaultTextStyle.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 20),
          Text('Check out this link:', style: _defaultTextStyle),
          const SizedBox(height: 30),
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onHover: onLinkHovered,
            mouseCursor: SystemMouseCursors.none,
            onTap: () => null,
            child: Ink(
              child: Column(
                children: [
                  Text('See what happens', style: _defaultTextStyle),
                  const SizedBox(height: 7),
                  Container(color: textColor, width: 50, height: 2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
