import 'package:athens/model/food.dart';
import 'package:athens/screens/food/food_card.dart';
import 'package:athens/service/food_service.dart';

import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  FoodList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: FoodService().getAllFood(),
      builder: (context, food) {
        Widget child;
        if (food.hasData) {
          child = ListView.separated(
            key: Key('1'),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: food.requireData.length,
            itemBuilder: (context, index) {
              return FoodCard(food.requireData[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          );
        } else if (food.hasError) {
          child = Text("Error");
        }
        else {
          child = SizedBox(key: Key('0'));
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
          child: child
        );
      },
    );
  }
}
