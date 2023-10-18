class FoodHero {
  final String name;
  String description = '';
  late final String image;

  FoodHero(this.name, [this.description = '']) {
    image = '$name.jpg';
  }
}