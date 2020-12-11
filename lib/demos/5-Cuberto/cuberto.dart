// Assets gotten from: https://cuberto-cursor.netlify.app
// Originally by cuberto.com

// BlendMask for images does not work on Flutter web, as well as Text Stroke.
// Known issues: https://github.com/flutter/flutter/issues/46683

import 'package:flutter/material.dart';

import '../../widgets/blend_mask.dart';

class Cuberto extends StatefulWidget {
  @override
  _CubertoState createState() => _CubertoState();
}

class _CubertoState extends State<Cuberto> with TickerProviderStateMixin {
  Offset mousePosition = Offset(0, 0);
  AnimationController pointerScaleController1;
  AnimationController pointerScaleController2;
  Animation pointerScaleAnimation1;
  Animation pointerScaleAnimation2;

  String selectedAsset = 'assets/images/apps.gif';

  @override
  void initState() {
    pointerScaleController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    pointerScaleController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    );
    pointerScaleAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.ease, parent: pointerScaleController1),
    );
    pointerScaleAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.ease, parent: pointerScaleController2),
    );
    super.initState();
  }

  @override
  void dispose() {
    pointerScaleController1.dispose();
    pointerScaleController2.dispose();
    super.dispose();
  }

  void firstScale(bool hovering) {
    if (hovering)
      pointerScaleController1.forward();
    else
      pointerScaleController1.reverse();
  }

  void secondScale(bool hovering) {
    if (hovering)
      pointerScaleController2.forward();
    else
      pointerScaleController2.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) => setState(() => mousePosition = e.position),
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              AnimatedBuilder(
                  animation: pointerScaleController1,
                  builder: (context, _) {
                    return AnimatedBuilder(
                        animation: pointerScaleController2,
                        builder: (context, _) {
                          final pointerScale = 1 +
                              pointerScaleAnimation1.value * 20 +
                              pointerScaleAnimation2.value * 20;

                          return AnimatedPositioned(
                            left: mousePosition.dx - 5,
                            top: mousePosition.dy - 5,
                            child: Transform.scale(
                              scale: pointerScale,
                              child: Container(
                                width: 10,
                                height: 10,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [],
                                  color:
                                      pointerScale <= 1 ? Colors.black : null,
                                  image: pointerScale > 1
                                      ? DecorationImage(
                                          image: AssetImage(selectedAsset),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutExpo,
                          );
                        });
                  }),
              SizedBox.expand(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HoverColumn(
                      title: 'Websites',
                      subtitle: 'We make it happen',
                      onTextHover: (e) {
                        secondScale(e);
                      },
                      onColumnHover: (e) {
                        firstScale(e);
                        setState(
                          () => selectedAsset = 'assets/images/websites.gif',
                        );
                      },
                    ),
                    HoverColumn(
                      title: 'Apps',
                      onTextHover: (e) {
                        secondScale(e);
                      },
                      onColumnHover: (e) {
                        firstScale(e);
                        setState(
                          () => selectedAsset = 'assets/images/apps.gif',
                        );
                      },
                    ),
                    HoverColumn(
                      title: 'Branding',
                      onTextHover: (e) {
                        secondScale(e);
                      },
                      onColumnHover: (e) {
                        firstScale(e);
                        setState(
                          () => selectedAsset = 'assets/images/branding.gif',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HoverColumn extends StatefulWidget {
  final Function(bool) onColumnHover;
  final Function(bool) onTextHover;
  final String title;
  final String subtitle;

  const HoverColumn({
    Key key,
    this.onColumnHover,
    @required this.title,
    this.onTextHover,
    this.subtitle = '',
  }) : super(key: key);
  @override
  _HoverColumnState createState() => _HoverColumnState();
}

class _HoverColumnState extends State<HoverColumn> {
  bool isHoveringOverText = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onColumnHover?.call(true),
      onExit: (_) => widget.onColumnHover?.call(false),
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: BlendMask(
                blendMode:
                    isHoveringOverText ? BlendMode.difference : BlendMode.xor,
                child: Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 22,
                    color: isHoveringOverText ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: AnimatedStrokedText(
                text: widget.title,
                onHover: (e) {
                  widget.onTextHover?.call(e);
                  setState(() => isHoveringOverText = e);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedStrokedText extends StatefulWidget {
  const AnimatedStrokedText({
    Key key,
    @required this.text,
    @required this.onHover,
  }) : super(key: key);
  final String text;
  final Function(bool) onHover;
  @override
  _AnimatedStrokedTextState createState() => _AnimatedStrokedTextState();
}

class _AnimatedStrokedTextState extends State<AnimatedStrokedText>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHover: (hovering) {
        widget.onHover(hovering);
        if (hovering)
          controller.forward();
        else
          controller.reverse();
      },
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, snapshot) {
              return BlendMask(
                opacity: 1 - controller.value,
                blendMode: BlendMode.xor,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                    // Comment this out on web
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.3
                      ..color = Colors.white,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return BlendMask(
                  opacity: controller.value,
                  blendMode: BlendMode.difference,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
