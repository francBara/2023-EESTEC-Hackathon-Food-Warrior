import 'package:athens/model/restaurant.dart';
import 'package:athens/screens/restaurant/restaurant_card.dart';
import 'package:athens/service/restaurants_service.dart';
import 'package:flutter/material.dart';

class RestaurantsList extends StatelessWidget {
  RestaurantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: RestaurantsService().getRestaurants(),
      builder: (context, restaurants) {
        Widget child;
        if (restaurants.hasData) {
          child = ListView.separated(
            key: Key('1'),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.requireData.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurants.requireData[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          );
        } else if (restaurants.hasError) {
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
