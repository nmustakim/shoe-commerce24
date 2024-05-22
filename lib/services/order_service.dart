import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/cart_item.dart';

class OrderService {
  final CollectionReference _ordersCollection =
  FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder(List<CartItemModel> orders, double totalPrice) async {
    try {
      var orderData = {
        'grandTotal': totalPrice,
        'orders': orders.map((order) => {
          'name': order.name,
          'brand': order.brand,
          'color': order.color,
          'size': order.size,
          'quantity': order.quantity,
          'price': order.price,
        }).toList(),
      };
      await _ordersCollection.add(orderData);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

}
