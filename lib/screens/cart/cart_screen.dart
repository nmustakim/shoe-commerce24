import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/global_widgets/k_bottom_bar.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/provider/cart_provider.dart';
import 'package:shoe_commerce/screens/cart/widgets/cart_item_widget.dart';
import 'package:shoe_commerce/screens/order_summary/order_summary_screen.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: const KAppBar(hasTitle: true, title: 'Cart'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Consumer<CartProvider>(
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
                        onAdd: () {
                          cartProvider.addToCart(cartItem.copyWith(quantity: 1));
                        },
                      );
                    },
                  ),
                ),

              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: primary,

        elevation: 1,
        child: KBottomBar(labelText: 'Grand Total', valueText: '\$${cartProvider.totalPrice.toStringAsFixed(2)}', buttonText: 'CHECK OUT', onButtonPressed: ()=>    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  OrderSummaryScreen(orders:cartProvider.items,totalPrice:cartProvider.totalPrice.toStringAsFixed(2) ,),
          ),
        )),
      ),
    );
  }
}
