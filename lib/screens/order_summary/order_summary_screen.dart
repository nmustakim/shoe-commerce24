import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/text_style.dart';
import '../../global_widgets/kappbar.dart';
import '../../global_widgets/kbutton.dart';


class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

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
              SizedBox(height: 16.h),
              Text('Information', style: headline600Medium),
              SizedBox(height: 8.h),
              Text('Payment Method', style: bodyText700SmallLight),
              Text('Credit Card', style: bodyText400Light),
              SizedBox(height: 16.h),
              Text('Location', style: bodyText700SmallLight),
              Text('Semarang, Indonesia', style: bodyText400Light),
              SizedBox(height: 16.h),
              Text('Order Detail', style: headline600Medium),
              SizedBox(height: 8.h),
              _buildOrderItem('Jordan 1 Retro High Tie Dye', 'Nike . Red Grey . 40 . Qty 1', 235.00),
              _buildOrderItem('Jordan 1 Retro High Tie Dye', 'Nike . Red Grey . 40 . Qty 1', 235.00),
              _buildOrderItem('Jordan 1 Retro High Tie Dye', 'Nike . Red Grey . 40 . Qty 1', 235.00),
              Spacer(),
              _buildPaymentDetail(),
              SizedBox(height: 16.h),
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

  Widget _buildOrderItem(String name, String details, double price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: bodyText700Small),
              Text(details, style: bodyText400LightSmall),
            ],
          ),
          Text('\$$price', style: bodyText700Small),
        ],
      ),
    );
  }

  Widget _buildPaymentDetail() {
    return Column(
      children: [
        _buildPaymentRow('Sub Total', 705.00),
        _buildPaymentRow('Shipping', 20.00),
        _buildPaymentRow('Total Order', 725.00),
        Divider(thickness: 1.h, color: Colors.black),
        _buildPaymentRow('Grand Total', 725.00, isGrandTotal: true),
      ],
    );
  }

  Widget _buildPaymentRow(String title, double amount, {bool isGrandTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isGrandTotal ? headline600Medium : bodyText700SmallLight),
          Text('\$$amount', style: isGrandTotal ? headline600Medium : bodyText700SmallLight),
        ],
      ),
    );
  }
}
