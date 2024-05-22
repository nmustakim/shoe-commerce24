import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/global_widgets/k_bottom_bar.dart';
import '../../const/color.dart';
import '../../const/text_style.dart';
import '../../global_widgets/kappbar.dart';
import '../../model/cart_item.dart';
import '../../provider/order_provider.dart';

class OrderSummaryScreen extends StatelessWidget {
  final List<CartItemModel> orders;
  final double totalPrice;
  const OrderSummaryScreen(
      {super.key, required this.orders, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: primary,
        child: KBottomBar(
          labelText: 'Grand Total',
          valueText: '\$${(totalPrice + 20.00).toStringAsFixed(2)}',
          buttonText: 'PAYMENT',
          onButtonPressed: () async{
            await Provider.of<OrderProvider>(context, listen: false).addOrder(orders, totalPrice);

          },
        ),
      ),
      appBar: const KAppBar(
        hasTitle: true,
        title: 'Order Summary',
        isDiscoverScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _verticalSpacing(16),
            Text('Information', style: headlineW700F18Dark),
            _verticalSpacing(24),
            Text('Payment Method', style: bodyTextW700F14Light),
            _verticalSpacing(12),
            Text('Debit Card', style: bodyTextW400F12Light),
            _verticalSpacing(45),
            Text('Location', style: bodyTextW700F14Light),
            _verticalSpacing(12),
            Text('Semarang, Indonesia', style: bodyTextW400F12Light),
            _verticalSpacing(24),
            Text('Order Detail', style: headlineW700F18Dark),
            _verticalSpacing(20),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return _buildOrderItem(order);
                },
              ),
            ),
            _verticalSpacing(16),
            Text('Payment Detail', style: headlineW700F18Dark),
            _verticalSpacing(16),
            _buildPaymentDetail(),
            _verticalSpacing(16),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItemModel order) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.name, style: bodyTextW700F14Dark),
              Row(
                children: [
                  _buildOrderItemText(order.brand),
                  _horizontalSpacing(12.w),
                  _buildOrderItemText(order.color),
                  _horizontalSpacing(12.w),
                  _buildOrderItemText(order.size),
                  _horizontalSpacing(12.w),
                  _buildOrderItemText('Qty ${order.quantity}'),
                ],
              ),
            ],
          ),
          Text('\$${order.price.toStringAsFixed(2)}', style: bodyTextW700F14Dark),
        ],
      ),
    );
  }

  Widget _buildOrderItemText(String text) {
    return Text(
      text,
      style: bodyTextW400F14LightDark,
    );
  }

  Widget _buildPaymentDetail() {
    return Column(
      children: [
        _buildPaymentRow('Sub Total', totalPrice),
        _buildPaymentRow('Shipping', 20.00),
        _buildPaymentRow('Total Order', totalPrice + 20.00),
      ],
    );
  }

  Widget _buildPaymentRow(String title, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: bodyTextW400F14LightDark),
          Text('\$${amount.toStringAsFixed(2)}', style: headlineW600F16),
        ],
      ),
    );
  }

  Widget _horizontalSpacing(double width) {
    return SizedBox(width: width.w);
  }

  Widget _verticalSpacing(double height) {
    return SizedBox(height: height.h);
  }
}
