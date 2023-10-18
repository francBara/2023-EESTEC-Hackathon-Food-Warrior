class Restaurant {
  late final String id;
  late final String name;
  late final String description;
  late final String category;
  late final String road;
  late final String publicKey;

  Restaurant(this.name, this.description) {
    id = '';
  }
  Restaurant.fromMap(Map<String, dynamic> restaurantMap) {
    id = restaurantMap['id'];
    name = restaurantMap['name'];
    description = restaurantMap['description'];
    category = restaurantMap['category'];
    road = restaurantMap['address'];
    publicKey = restaurantMap['public_key'];
  }
}
