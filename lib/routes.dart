import 'package:flutter/material.dart';
import 'package:shoe_commerce/screens/cart/cart_screen.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';
import 'package:shoe_commerce/screens/filter_screen/filter_screen.dart';
import 'package:shoe_commerce/screens/order_summary/order_summary_screen.dart';
import 'package:shoe_commerce/screens/product_details/priduct_details_screen.dart';
import 'package:shoe_commerce/screens/reviews/review_screen.dart';

class AppRoutes {
  static const String discoverShoes = '/discover_shoes';
  static const String filterScreen = '/filter_screen';
  static const String productDetails = '/product_details';
  static const String reviewScreen = '/review_screen';
  static const String cartScreen = '/cart_screen';
  static const String orderSummaryScreen = '/order_summary_screen';

  static Map<String, WidgetBuilder> generateRoutes = {
    discoverShoes: (context) => const DiscoverShoes(),
    filterScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        return FilterScreen(selectedBrand: args['selectedBrand']);
      }
      // Handle the case when arguments are not provided
      return const Scaffold(
        body: Center(
          child: Text('Error: Missing arguments for FilterScreen'),
        ),
      );
    },
    productDetails: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        return ProductDetailsScreen(shoe: args['shoe']);
      }
      // Handle the case when arguments are not provided
      return const Scaffold(
        body: Center(
          child: Text('Error: Missing arguments for ProductDetailsScreen'),
        ),
      );
    },
    reviewScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        return ReviewScreen(shoe: args['shoe']);
      }
      // Handle the case when arguments are not provided
      return const Scaffold(
        body: Center(
          child: Text('Error: Missing arguments for ReviewScreen'),
        ),
      );
    },
    cartScreen: (context) => const ShoppingCartScreen(), // Corrected assignment
    orderSummaryScreen: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        return OrderSummaryScreen(
          orders: args['orders'],
          totalPrice: args['totalPrice'],
        );
      }
      // Handle the case when arguments are not provided
      return const Scaffold(
        body: Center(
          child: Text('Error: Missing arguments for OrderSummaryScreen'),
        ),
      );
    },
  };
}
