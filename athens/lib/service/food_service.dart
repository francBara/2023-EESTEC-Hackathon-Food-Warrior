import 'package:athens/model/food.dart';
import 'package:athens/model/restaurant.dart';
import 'package:athens/service/skeleton/authentication.dart';
import 'package:athens/service/skeleton/backend.dart';
import 'package:athens/service/skeleton/database.dart';
import 'package:athens/service/skeleton/storage.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodService {
  Future<List<Food>> getFood(Restaurant restaurant) async {
    return (await Database.getAll('restaurants/${restaurant.id}/food')).map((foodMap) {
      Food food = Food.fromMap(foodMap);
      food.restaurant = restaurant;
      return food;
    }).toList();
  }

  Future<List<Food>> getAllFood() async {
    return (await Database.getAllGroup('food')).map((foodMap) {
      return Food.fromMap(foodMap);
    }).toList();
  }

  static Future<FadeInImage> getFoodImage(Food food) async {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      fadeInDuration: Duration(milliseconds: 150),
      fadeOutDuration: Duration(milliseconds: 150),
      fadeInCurve: Curves.easeOut,
      fadeOutCurve: Curves.easeOut,
      image: await Storage.getImageURL(
          'restaurants/food/${food.id}'),
      fit: BoxFit.cover,
    );
  }

  static Future<String> buyFood(Food food, bool withTokens) async {
    var res = await Backend.post('buyFood', {
      'food_id': food.id,
      'restaurant_id': food.restaurantId,
      'user_token': await Authentication.getAuthToken(),
      'with_tokens': withTokens
    });
    if (res.containsKey('earned')) {
      Authentication.user.points.value = res['earned'];
    }
    return res["tx"];
  }
}
