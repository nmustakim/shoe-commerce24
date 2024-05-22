import 'package:flutter/material.dart';

class CartItemModel {
  final String name;
  final String brand;
  final String color;
  final String size;
  final String image;
  final double price;
  final int quantity;

  CartItemModel({
    required this.name,
    required this.brand,
    required this.color,
    required this.size,
    required this.image,
    required this.price,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      name: name,
      brand: brand,
      color: color,
      size: size,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final CartItemModel otherItem = other as CartItemModel;
    return name == otherItem.name &&
        brand == otherItem.brand &&
        color == otherItem.color &&
        size == otherItem.size &&
        image == otherItem.image &&
        price == otherItem.price;
  }

  @override
  int get hashCode => Object.hash(name, brand, color, size, image, price);
}
