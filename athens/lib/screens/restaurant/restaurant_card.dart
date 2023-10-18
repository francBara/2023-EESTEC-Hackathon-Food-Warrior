import 'package:athens/model/restaurant.dart';
import 'package:athens/screens/restaurant/restaurant_screen.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';
import 'restaurant_image.dart';

class RestaurantCard extends StatelessWidget {
  final containerRadius = BorderRadius.all(Radius.circular(20));
  final ThemeModel theme = ThemeModel.instance;

  final Restaurant restaurant;

  RestaurantCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 70;

    return Clickable(
        onTap: () {
          Routing.slideToPage(context, RestaurantScreen(restaurant));
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            decoration: BoxDecoration(borderRadius: containerRadius),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  child: RestaurantImage(restaurant.id, 130, width),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    restaurant.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 16, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(restaurant.road + ' • ' + restaurant.category,
                          style: TextStyle(
                              fontSize: 15,
                              color: theme.secondaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
