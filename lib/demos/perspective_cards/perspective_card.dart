import 'package:flutter/material.dart';

class PerspectiveCard extends StatelessWidget {
  const PerspectiveCard({Key key, @required this.imageAsset}) : super(key: key);
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
        boxShadow: [BoxShadow(blurRadius: 50, spreadRadius: -10)],
      ),
    );
  }
}
