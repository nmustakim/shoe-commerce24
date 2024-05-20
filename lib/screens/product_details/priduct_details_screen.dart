import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';

import '../../const/text_style.dart';
import '../../model/shoe.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Shoe shoe;
  const ProductDetailsScreen({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset('assets/images/bag-2.png'),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          children: [
            Container(
              height: 315.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: secondaryBackground,

                  borderRadius: BorderRadius.circular(20.r)),
              child: Image.network(shoe.image,height: 178.h,width: 252.w,),
            ),
            SizedBox(height: 20.h,),
            Text(shoe.name,style: bodyText700,)
          ],
        ),
      ),
    );
  }
}
