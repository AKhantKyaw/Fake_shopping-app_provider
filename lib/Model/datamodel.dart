import 'package:flutter/material.dart';

class Cart {
  final int? id;
  final String productName;
  final int initialPrice;
  final int productPrice;
  final String quality;
  final int color;
  final String image;
  final ValueNotifier<int>? count;
  Cart({
    this.id,
    required this.count,
    required this.color,
    required this.productName,
    required this.image,
    required this.initialPrice,
    required this.productPrice,
    required this.quality,
  });
  Cart.fromMap(
    Map<dynamic, dynamic> data,
  )   : id = data['id'],
        productName = data['productname'],
        color = data["color"],
        initialPrice = data['initialprice'],
        productPrice = data['productprice'],
        quality = data['quality'],
        image = data['image'],
        count = ValueNotifier(data['count']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'productname': productName,
      'initialprice': initialPrice,
      'productprice': productPrice,
      'quality': quality,
      'image': image,
      'count': count?.value,
    };
  }


  Map<String, dynamic> qualityMap() {
    return {
      'id': id,
      'count': count!.value,
    };
  }
}
