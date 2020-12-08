import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'city.dart';
import 'city_card.dart';

class CityCards extends StatelessWidget {
  final dummyText = LIPSUM.substring(0, 100);

  @override
  Widget build(BuildContext context) {
    final cityList = <City>[
      City(
        name: 'London',
        description: dummyText,
        image: 'assets/images/big_ben.jpeg',
      ),
      City(
        name: 'Paris',
        description: dummyText,
        image: 'assets/images/eiffel.jpeg',
      ),
      City(
        name: 'Rome',
        description: dummyText,
        image: 'assets/images/colosseum.jpeg',
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
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
