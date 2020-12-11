import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'perspective_card.dart';

class PerspectiveCards extends StatefulWidget {
  @override
  _PerspectiveCardsState createState() => _PerspectiveCardsState();
}

class _PerspectiveCardsState extends State<PerspectiveCards>
    with SingleTickerProviderStateMixin {
  double relativeDx = 0;
  double relativeDy = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: _manageOnHover,
        child: SizedBox.expand(
          child: Center(
            child: Transform.translate(
              offset: Offset(0, 0),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(
                      100 * relativeDx,
                      50 * relativeDy,
                    ),
                    child: Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(0.3 * relativeDx),
                      child: PerspectiveCard(
                        imageAsset: 'assets/images/eiffel.jpeg',
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(10 * relativeDx, 10 * relativeDy),
                    child: Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(0.2 * relativeDx),
                      child: PerspectiveCard(
                        imageAsset: 'assets/images/colosseum.jpeg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _manageOnHover(PointerHoverEvent e) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final referenceWidth = (screenWidth) / 2;
    final newRelativeDx = (referenceWidth - e.position.dx) / referenceWidth;
    final referenceHeight = (screenHeight) / 2;
    final newRelativeDy = (referenceHeight - e.position.dy) / referenceHeight;

    setState(() => relativeDx = newRelativeDx);

    setState(() => relativeDy = newRelativeDy);
  }
}
