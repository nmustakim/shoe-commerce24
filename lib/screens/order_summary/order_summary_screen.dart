import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/text_style.dart';
import '../../global_widgets/kappbar.dart';
import '../../global_widgets/kbutton.dart';
import '../../model/cart_item.dart';

class OrderSummaryScreen extends StatelessWidget {
  final List<CartItemModel> orders;
  const OrderSummaryScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _verticalSpacing16(),
            Text('Information', style: headlineW700F18Dark),
            _verticalSpacing24(),
            Text('Payment Method', style: bodyTextW700F14Light),
            _verticalSpacing12(),
            Text('Debit Card', style: bodyTextW400F12Light),
            _verticalSpacing45(),
            Text('Location', style: bodyTextW700F14Light),
            _verticalSpacing12(),
            Text('Semarang, Indonesia', style: bodyTextW400F12Light),
            _verticalSpacing24(),
            Text('Order Detail', style: headlineW700F18Dark),
            _verticalSpacing20(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return _buildOrderItem(order);
                }),
            _verticalSpacing16(),
            const Spacer(),
            Text(
              'Payment Detail',
              style: headlineW700F18Dark,
            ),
            _verticalSpacing16(),
            _buildPaymentDetail(),
            _verticalSpacing16(),
            KButton(
              text: 'PAYMENT',
              onPressed: () {},
              height: 50.h,
              width: double.infinity,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemText(String text) {
    return Text(
      text,
      style: bodyTextW400F14LightDark,
    );
  }

  Widget _horizontalSpacing12() {
    return SizedBox(
      width: 12.w,
    );
  }

  Widget _verticalSpacing20() {
    return SizedBox(
      height: 20.h,
    );
  }

  Widget _verticalSpacing24() {
    return SizedBox(
      height: 24.h,
    );
  }

  Widget _verticalSpacing45() {
    return SizedBox(
      height: 45.h,
    );
  }

  Widget _verticalSpacing12() {
    return SizedBox(
      height: 12.h,
    );
  }

  Widget _verticalSpacing16() {
    return SizedBox(
      height: 16.h,
    );
  }

  Widget _verticalSpacing8() {
    return SizedBox(
      height: 8.h,
    );
  }

  Widget _buildOrderItem(
     CartItemModel order) {
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
                  _horizontalSpacing12(),
                  _buildOrderItemText(order.color),
                  _horizontalSpacing12(),
                  _buildOrderItemText(order.size),
                  _horizontalSpacing12(),
                  _buildOrderItemText('Qty ${order.quantity}')
                ],
              )
            ],
          ),
          Text('\$${order.price}', style: bodyTextW700F14Dark),
        ],
      ),
    );
  }

  Widget _buildPaymentDetail(BuildContext context) {
    return Column(
      children: [
        _buildPaymentRow('Sub Total', 705.00),
        _buildPaymentRow('Shipping', 20.00),
        _buildPaymentRow('Total Order', 725.00),
        Divider(thickness: 1.h, color: Colors.black),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grand Total',
                  style: bodyTextW400F12Light,
                ),
                Text(
                  or,
                  style: bodyTextW700F20Dark,
                ),
              ],
            ),
            KButton(
              text: 'PAYMENT',
              onPressed: () {


              },
              height: 50.w,
              width: 156.w,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentRow(
    String title,
    double amount,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: bodyTextW400F14LightDark),
          Text('\$$amount', style: headlineW600F16),
        ],
      ),
    );
  }




}
