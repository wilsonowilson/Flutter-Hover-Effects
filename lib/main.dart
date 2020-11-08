import 'package:flutter/material.dart';

import 'demos/see_through/see_through.dart';

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
      home: SeeThrough(),
    );
  }
}
