import 'package:flutter/material.dart';

import 'perspective_card.dart';

class PerspectiveCards extends StatefulWidget {
  @override
  _PerspectiveCardsState createState() => _PerspectiveCardsState();
}

class _PerspectiveCardsState extends State<PerspectiveCards>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey();
  var screenWidth = 0.0;
  AnimationController perspectiveController;
  Animation<double> perspectiveAnimation;

  @override
  void initState() {
    perspectiveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    perspectiveAnimation = Tween<double>(begin: -1, end: 1).animate(
        CurvedAnimation(
            curve: Curves.easeInOutCubic, parent: perspectiveController));
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());
    super.initState();
  }

  @override
  void dispose() {
    perspectiveController.dispose();
    super.dispose();
  }

  void getHeight() {
    final state = key.currentState;
    final RenderBox box = state.context.findRenderObject();
    setState(() {
      screenWidth = box.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        backgroundColor: Colors.black,
        body: MouseRegion(
          onEnter: (e) {},
          onHover: (e) {
            final isLeft = e.localPosition.dx <= (screenWidth / 2);
            if (!perspectiveController.isAnimating) {
              if (isLeft)
                perspectiveController.forward();
              else
                perspectiveController.reverse();
            }
          },
          child: SizedBox.expand(
            child: Center(
              child: AnimatedBuilder(
                  animation: perspectiveController,
                  builder: (context, snapshot) {
                    return Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(100 * perspectiveAnimation.value, 160),
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(0.3 * perspectiveAnimation.value),
                            child: PerspectiveCard(
                              imageAsset: 'images/eiffel.jpeg',
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(10 * perspectiveAnimation.value, 0),
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(0.2 * perspectiveAnimation.value),
                            child: PerspectiveCard(
                              imageAsset: 'images/colosseum.jpeg',
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ));
  }
}
