import 'package:flutter/material.dart';
import '../model/cart_item.dart';
import '../services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  Future<void> addOrder(List<CartItemModel> orders, double totalPrice) async {
    try {
      await _orderService.addOrder(orders, totalPrice);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
