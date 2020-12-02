// * Unsupported on Flutter web. Check out this issue:
// https://github.com/flutter/flutter/issues/44152

import 'package:flutter/material.dart';

class SeeThrough extends StatefulWidget {
  @override
  _SeeThroughState createState() => _SeeThroughState();
}

class _SeeThroughState extends State<SeeThrough> {
  Offset mousePosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage('assets/images/colosseum.jpeg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox.expand(
              child: ShaderMask(
                blendMode: BlendMode.srcOut,
                shaderCallback: (bounds) => LinearGradient(
                    colors: [Color.fromARGB(255, 25, 25, 25)],
                    stops: [0.0]).createShader(bounds),
                child: Container(
                  color: Colors.transparent,
                  child: Transform.translate(
                    offset:
                        Offset(mousePosition.dx - 100, mousePosition.dy - 100),
                    child: Stack(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Jumping Through Portals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
