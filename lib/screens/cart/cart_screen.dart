import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/global_widgets/k_bottom_bar.dart';
import 'package:shoe_commerce/global_widgets/k_appbar.dart';
import 'package:shoe_commerce/helper/navigation_helper.dart';
import 'package:shoe_commerce/providers/cart_provider.dart';
import 'package:shoe_commerce/screens/cart/widgets/cart_item_widget.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: const KAppBar(hasTitle: true, title: 'Cart'),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.items[index];
                      return CartItemWidget(
                          cartItem: cartItem,
                          onRemove: () {
                            cartProvider.decrementQuantity(cartItem);
                          },
                          onAdd: () => cartProvider
                              .addToCart(cartItem.copyWith(quantity: 1)));
                    },
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: primary,
          elevation: 1,
          child: KBottomBar(
              labelText: 'Grand Total',
              valueText: '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
              buttonText: 'CHECK OUT',
              onButtonPressed: () {
                if (cartProvider.items.isNotEmpty) {
                  NavigationHelper.navigateToOrderSummaryScreen(
                    context,
                    cartProvider.items,
                    cartProvider.totalPrice,
                  );
                }
              }),
        ));
  }
}
