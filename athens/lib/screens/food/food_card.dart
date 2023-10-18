import 'package:athens/model/food.dart';
import 'package:athens/model/utils/athens_strings.dart';
import 'package:athens/screens/food/food_image.dart';
import 'package:athens/screens/order/food_order.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/overlay_loader.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';
import '../restaurant/restaurant_image.dart';

class FoodCard extends StatelessWidget {
  final containerRadius = BorderRadius.all(Radius.circular(20));
  final ThemeModel theme = ThemeModel.instance;
  final Food food;

  FoodCard(this.food);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 70;

    return Clickable(
      onTap: () async {
        if (food.restaurant == null) {
          OverlayLoader.showLoading(context);
          try {
            await food.getRestaurant();
            OverlayLoader.unshowLoading();
          } catch (e) {
            OverlayLoader.unshowLoading();
          }
        }
        Routing.slideToPage(context, FoodOrder(food));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Container(
          decoration: BoxDecoration(borderRadius: containerRadius),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                child: FoodImage(food, 130, width),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  food.name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(food.category,
                        style: TextStyle(
                            fontSize: 17,
                            color: theme.secondaryColor,
                            fontWeight: FontWeight.w500)),
                    Text(AthensStrings.centsToString(food.price) + '€',
                        style: TextStyle(
                            fontSize: 22,
                            color: theme.secondaryColor,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
