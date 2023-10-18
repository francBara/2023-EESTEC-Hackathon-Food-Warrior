

import 'package:athens/service/skeleton/database.dart';
import 'package:athens/service/skeleton/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/restaurant.dart';

class RestaurantsService {
  Future<List<Restaurant>> getRestaurants() async {
    return (await Database.getAll('restaurants')).map((restaurantMap) => Restaurant.fromMap(restaurantMap)).toList();
  }

  Future<FadeInImage> getRestaurantImage(String restaurantId) async {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      fadeInDuration: Duration(milliseconds: 150),
      fadeOutDuration: Duration(milliseconds: 150),
      fadeInCurve: Curves.easeOut,
      fadeOutCurve: Curves.easeOut,
      image: await Storage.getImageURL('restaurants/$restaurantId'),
      fit: BoxFit.cover,
    );
  }
}