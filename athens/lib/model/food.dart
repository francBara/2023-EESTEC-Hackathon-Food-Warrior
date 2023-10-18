import 'package:athens/service/skeleton/database.dart';

import 'restaurant.dart';

class Food {
  late final String name;
  late final String description;
  late final int price;
  late final String id;
  late final String restaurantId;
  late double reward;
  late final String category;

  Restaurant? restaurant = null;

  Food.fromMap(Map<String, dynamic> foodMap) {
    name = foodMap['name'];
    description = foodMap['description'];
    price = foodMap['price'];
    id = foodMap['id'];
    category = foodMap['category'];
    restaurantId = foodMap['restaurant_id'];
    reward = foodMap['reward'].toDouble();
  }

  Future<void> getRestaurant() async {
    if (restaurant != null) {
      return;
    }
    restaurant = Restaurant.fromMap(await Database.get('restaurants', restaurantId));
  }
}
