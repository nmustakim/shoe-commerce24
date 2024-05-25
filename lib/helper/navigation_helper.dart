import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';
import '../models/shoe.dart';
import '../routes.dart';
import '../services/navigation_service.dart';

class NavigationHelper {
  static Future<dynamic> navigateToDiscoverShoes(BuildContext context) {
    return NavigationService.navigateToNamedRoute(AppRoutes.discoverShoes);
  }

  static Future<dynamic> navigateToFilterScreen(BuildContext context, String selectedBrand) {
    return NavigationService.navigateToNamedRoute(
      AppRoutes.filterScreen,
      arguments: {'selectedBrand': selectedBrand},
    );
  }

  static Future<dynamic> navigateToProductDetails(BuildContext context, Shoe shoe) {
    return NavigationService.navigateToNamedRoute(
      AppRoutes.productDetails,
      arguments: {'shoe': shoe},
    );
  }

  static Future<dynamic> navigateToReviewScreen(BuildContext context, Shoe shoe) {
    return NavigationService.navigateToNamedRoute(
      AppRoutes.reviewScreen,
      arguments: {'shoe': shoe},
    );
  }

  static Future<dynamic> navigateToCartScreen(BuildContext context) {
    return NavigationService.navigateToNamedRoute(AppRoutes.cartScreen);
  }

  static Future<dynamic> navigateToOrderSummaryScreen(BuildContext context, List<CartItemModel> orders, double totalPrice) {
    return NavigationService.navigateToNamedRoute(
      AppRoutes.orderSummaryScreen,
      arguments: {'orders': orders, 'totalPrice': totalPrice},
    );
  }
}
