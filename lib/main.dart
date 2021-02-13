import 'package:flutter/material.dart';

import 'demos/7-Cursor-Carousel/cursor_carousel.dart';

void main() {
  runApp(HoverEffectGallery());
}

class HoverEffectGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover Effects',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Averta',
        primarySwatch: Colors.green,
      ),
      home: CursorCarousel(),
    );
  }
}
