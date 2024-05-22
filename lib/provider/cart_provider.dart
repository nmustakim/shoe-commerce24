import 'package:flutter/material.dart';
import 'package:shoe_commerce/model/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];
  double _totalPrice = 0.0;

  List<CartItemModel> get items => _items;
  double get totalPrice => _totalPrice;

  void addToCart(CartItemModel cartItem) {
    final existingIndex = _items.indexWhere((item) => item == cartItem);
    if (existingIndex != -1) {
      _items[existingIndex] = _items[existingIndex].copyWith(quantity: _items[existingIndex].quantity + cartItem.quantity);
    } else {
      _items.add(cartItem);
    }
    _updateTotalPrice();
    notifyListeners();
  }

  void removeFromCart(CartItemModel cartItem) {
    _items.removeWhere((item) => item == cartItem);
    _updateTotalPrice();
    notifyListeners();
  }

  void decrementQuantity(CartItemModel cartItem) {
    final existingIndex = _items.indexWhere((item) => item == cartItem);
    if (existingIndex != -1) {
      final currentQuantity = _items[existingIndex].quantity;
      if (currentQuantity > 1) {
        _items[existingIndex] = _items[existingIndex].copyWith(quantity: currentQuantity - 1);
      } else {
        _items.removeAt(existingIndex);
      }
      _updateTotalPrice();
      notifyListeners();
    }
  }

  void _updateTotalPrice() {
    _totalPrice = 0;
    for (var item in _items) {
      _totalPrice += item.price * item.quantity;
    }
  }
}
