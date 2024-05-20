import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';

import '../../../model/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;


  const ShoeCard({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 150.h,
              width: 150.h,
              child: Card(
                color: productBackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r),

                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                    child: Container(
                        margin:EdgeInsets.only(bottom: 16.h),
                        child: Image.network(shoe.image)),),

              ),
            ),
            Positioned(
              left: 24.w,
                top: 16.h,
                child: Image.network(shoe.logo))
          ],
        ),
        SizedBox(height: 8.h,),

        Container(
          margin: EdgeInsets.only(left: 8.h),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(shoe.title,
                style:
                    bodyText400Dark),
          ),
        ),
        SizedBox(height: 4.h,),

        Container(
          margin: EdgeInsets.only(left: 6.h),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16.sp),
              SizedBox(width: 4.h,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${shoe.rating}',
                      style: headline700.copyWith(fontSize: 11.sp),
                    ),

                    TextSpan(
                      text: ' (${shoe.reviewCount} Reviews)',
                      style: bodyText400Light,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(left: 8.h),
            child: Text('\$${shoe.price.toStringAsFixed(2)}',
                style: bodyText400Dark.copyWith(fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}
