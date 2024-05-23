import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/providers/cart_provider.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';

import '../models/cart_item.dart';
import '../services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  Future<void> addOrder(List<CartItemModel> orders, double totalPrice,context) async {
    _errorMessage = '';
    _successMessage = '';
    _isLoading = true;
    notifyListeners();
    try {
      await _orderService.addOrder(orders, totalPrice);
      _successMessage = 'Your order has been processed successfully.';
      showToast(_successMessage);
      Provider.of<CartProvider>(context,listen: false).resetCart();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const DiscoverShoes()));
    } catch (e) {
      _errorMessage = 'An error occurred while processing your order. Please try again.';
      showToast(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
