class Item {
  final int? id;
  final String name;
  final int unit;
  final int price;
  final String image;
  Item(
      {this.id,
      required this.name,
      required this.unit,
      required this.price,
      required this.image});
  Map toJson() {
    return {
      'name': name,
      'unit': unit,
      'price': price,
      'image': image,
    };
  }
}
