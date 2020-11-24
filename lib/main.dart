import 'package:flutter/material.dart';

import 'demos/4-Cursor-Blending/cursor_blending.dart';

void main() {
  runApp(HoverEffectGallery());
}

class HoverEffectGallery extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Averta',
        primarySwatch: Colors.green,
      ),
      home: CursorBlending(),
    );
  }
}
