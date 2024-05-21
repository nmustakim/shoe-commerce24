import 'package:flutter/material.dart';
import 'package:shoe_commerce/model/shoe.dart';
import 'package:shoe_commerce/model/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  double _totalPrice = 0.0;

  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;

  void addToCart(Shoe shoe, int quantity) {
    final existingIndex = _items.indexWhere((item) => item.shoe == shoe);
    if (existingIndex != -1) {
      _items[existingIndex] = _items[existingIndex].copyWith(quantity: _items[existingIndex].quantity + quantity);
    } else {
      _items.add(CartItem(shoe: shoe, quantity: quantity));
    }
    _updateTotalPrice();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _items.remove(cartItem);
    _updateTotalPrice();
    notifyListeners();
  }

  void _updateTotalPrice() {
    _totalPrice = 0;
    for (var item in _items) {
      _totalPrice += item.shoe.price * item.quantity;
    }
  }
}
