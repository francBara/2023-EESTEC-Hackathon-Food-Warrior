import 'package:athens/model/food.dart';
import 'package:athens/service/food_service.dart';
import 'package:athens/service/restaurants_service.dart';
import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  final Food food;
  final double height;
  final double width;

  FoodImage(this.food, this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FadeInImage>(
      future: FoodService.getFoodImage(food),
      builder: (context, pic) {
        Widget child;
        if (pic.hasData) {
          child = SizedBox(
            height: height,
            width: width,
            child: pic.requireData,
            key: ValueKey(0),
          );
        } else if (pic.hasError) {
          child = Container(
            height: height,
            width: width,
            color: Colors.grey,
          );
          /*
          child = SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              'lib/assets/placeholder.png',
              fit: BoxFit.cover,
              key: ValueKey(1),
            ),
          );
           */
        } else {
          child = SizedBox(height: height, width: width, key: ValueKey(2));
        }
        return AnimatedSwitcher(
          child: child,
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeOut,
          duration: Duration(milliseconds: 150),
          reverseDuration: Duration(milliseconds: 150),
        );
      },
    );
  }
}
