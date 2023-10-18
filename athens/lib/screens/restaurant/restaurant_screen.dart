import 'package:athens/model/food.dart';
import 'package:athens/model/restaurant.dart';
import 'package:athens/screens/food/food_card.dart';
import 'package:athens/screens/restaurant/restaurant_image.dart';
import 'package:athens/screens/utils/loading_indicator.dart';
import 'package:athens/service/food_service.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';

class RestaurantScreen extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;

  final Restaurant restaurant;

  RestaurantScreen(this.restaurant);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            //title: Text(restaurant.name),
            stretch: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            //stretchTriggerOffset: 200, altezza a cui triggherare la funzione onStretchTrigger
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                child: RestaurantImage(restaurant.id, 300, width),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(restaurant.name,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 4,
                        decoration: BoxDecoration(
                            color: theme.maincolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text('On ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Container(
                            child: Text(restaurant.road,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(restaurant.category,
                            style: TextStyle(
                                fontSize: 16,
                                color: theme.secondaryColor,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                // Testo
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(restaurant.description,
                      style: TextStyle(fontSize: 16)),
                ),
                // * Food List
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  height: 240,
                  child: FutureBuilder<List<Food>>(
                    future: FoodService().getFood(restaurant),
                    builder: (context, food) {
                      if (food.hasData) {
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: food.requireData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return FoodCard(food.requireData[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                        );
                      } else if (food.hasError) {
                        return Text("Error");
                      }
                      return LoadingIndicator();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
