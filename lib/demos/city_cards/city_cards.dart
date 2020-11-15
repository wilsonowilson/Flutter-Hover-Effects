import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants.dart';

class City {
  final String name;
  final String description;
  final String image;

  City({
    @required this.name,
    @required this.description,
    @required this.image,
  });
}

class CityCard extends StatefulWidget {
  final String imageAsset;
  final String cityName;
  final String cityDescription;

  const CityCard({
    Key key,
    @required this.imageAsset,
    @required this.cityName,
    @required this.cityDescription,
  }) : super(key: key);

  @override
  _CityCardState createState() => _CityCardState();
}

class _CityCardState extends State<CityCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: Tween<double>(begin: 1, end: 0).animate(controller),
      curve: Curves.easeInOutQuad,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      onHover: (e) {
        if (e)
          controller.forward();
        else
          controller.reverse();
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Transform.scale(
              scale: 0.4 * (1 - animation.value + 2.5),
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateZ((-pi / 4) * animation.value * 0.5),
                child: Container(
                  width: 240,
                  height: 350,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(widget.imageAsset),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 50,
                          spreadRadius: -10,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topCenter,
                            colors: [Colors.black54, Colors.black12],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.cityDescription,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class CityCards extends StatelessWidget {
  final dummyText = LIPSUM.substring(0, 100);

  @override
  Widget build(BuildContext context) {
    final cityList = <City>[
      City(
        name: 'London',
        description: dummyText,
        image: 'images/big_ben.jpeg',
      ),
      City(
        name: 'Paris',
        description: dummyText,
        image: 'images/eiffel.jpeg',
      ),
      City(
        name: 'Rome',
        description: dummyText,
        image: 'images/colosseum.jpeg',
      ),
    ];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 20, 30),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cityList
                        .map(
                          (e) => CityCard(
                              imageAsset: e.image,
                              cityName: e.name,
                              cityDescription: e.description),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
