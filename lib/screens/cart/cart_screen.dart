import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/screens/order_summary/order_summary_screen.dart';



class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const KAppBar(hasTitle: true,title: 'Cart',),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grand Total',
                            style: bodyText400Light,
                          ),
                          Text(
                            '\$705.00',
                            style: bodyText700Medium,
                          ),
                        ],
                      ),
                      KButton(text: 'CHECK OUT', onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const OrderSummaryScreen()));
                      }

                          , height: 50.w, width: 156.w)

                    ],
                  ),




          ],
        ),
      ),
    );
  }
}

