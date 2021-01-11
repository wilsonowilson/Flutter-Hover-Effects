import 'package:flutter/material.dart';

import 'city.dart';
import 'city_card.dart';

class CityCards extends StatefulWidget {
  @override
  _CityCardsState createState() => _CityCardsState();
}

class _CityCardsState extends State<CityCards> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  bool opaque = false;

  ScrollController scrollController = ScrollController();

  double relativeDx = 0;
  double gradientDisplacement = -0.1;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final relativeDx =
        scrollController.offset / scrollController.position.maxScrollExtent;
    setState(() {
      this.relativeDx = relativeDx;
    });
  }

  void _runAnimations() async {
    for (var city in cityList) {
      await precacheImage(NetworkImage(city.image), context);
    }
    setState(() {
      opaque = true;
    });
    await Future.delayed(Duration(milliseconds: 300));
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    _runAnimations();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final totDxGrad = gradientDisplacement * relativeDx;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            stops: [
              0.3 + totDxGrad,
              0.6 + totDxGrad,
              0.6 + totDxGrad,
              0.9 + totDxGrad
            ],
            colors: [
              Color.fromARGB(255, 3, 3, 10),
              Color.fromARGB(255, 10, 10, 20),
              Colors.indigo,
              Colors.cyan.shade200,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 90, right: 50),
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opaque ? 1 : 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                            animation: animation,
                            builder: (context, _) {
                              return Text(
                                'Travel\nthe world!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.white.withOpacity(
                                              0.54 * animation.value)),
                                    ]),
                              );
                            }),
                        SizedBox(height: 20),
                        Text(
                          'Pick a country you want to go to!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ...cityList
                      .map(
                        (e) => AnimatedBuilder(
                          animation: animation,
                          builder: (context, _) {
                            return Transform.translate(
                              offset: Offset(
                                  0,
                                  (50 + (50) * cityList.indexOf(e)) *
                                      (1 - animation.value)),
                              child: Opacity(
                                opacity: animation.value,
                                child: CityCard(
                                  imageUrl: e.image,
                                  cityName: e.name,
                                  cityDescription: e.description,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final cityList = <City>[
  City(
    name: 'London',
    description:
        'London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.',
    image:
        'https://images.unsplash.com/photo-1500319504970-a53dc034bc15?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80',
  ),
  City(
    name: 'Paris',
    description:
        "Paris, France's capital, is a major European city and a global center for art, fashion, gastronomy and culture. Its 19th-century cityscape is crisscrossed by wide boulevards and the River Seine. Beyond such landmarks as the Eiffel Tower and the 12th-century, ",
    image:
        'https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80',
  ),
  City(
    name: 'Rome',
    description:
        "Rome is the capital city and a special comune of Italy, as well as the capital of the Lazio region. The city has been a major human settlement for almost three millennia. With 2,860,009 residents in 1,285 km², it is also the country's most populated comune",
    image:
        'https://images.unsplash.com/photo-1552076170-3b3f5c8fe1c6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=564&q=80',
  ),
];
