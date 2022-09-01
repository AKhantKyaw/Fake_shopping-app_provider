import 'package:shopping_app_with_provider/Model/item_model.dart';

class ProductsItem {
  List<Item> products = [
    Item(
      name: 'Nike Shoe',
      unit: 1,
      price: 150,
      image: 'images/nike_shoe1.png',
    ),
    Item(
        name: "Jordan Shoe",
        unit: 2,
        price: 130,
        image: 'images/jardonshoe.png'),
    Item(
        name: 'Gentleman',
        unit: 3,
        price: 325,
        image: 'images/geneman.png'),
    Item(
        name: 'All Star',
        unit: 4,
        price: 450,
        image: 'images/convertblack.png'),
    Item(
        name: 'All Star lv2',
        unit: 5,
        price: 619,
        image: 'images/convertlongshoe.png'),
    Item(
        name: 'Adidas Shoe',
        unit: 6,
        price: 340,
        image: 'images/adides-download.png'),
    Item(
        name: 'Lady Shoe',
        unit: 7,
        price: 234,
        image: 'images/ladyshoe.png'),
    Item(
        name: 'women-Shoe',
        unit: 8,
        price: 150,
        image: 'images/women.png')
  ];
}
