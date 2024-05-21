import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';

import '../../../model/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;
  final VoidCallback onTap;

  const ShoeCard({super.key, required this.shoe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 135.h,
            width: 155.w,
            child: Stack(
              children: [
                Card(
                  color: secondaryBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: Image.network(shoe.images.first,width: 120.w,fit: BoxFit.fitWidth, )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left:20.w,top: 16.h ),
                    child: Image.network(shoe.logo))

              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(shoe.name, style: bodyText400Dark),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 6.w),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                SizedBox(
                  width: 4.w,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${shoe.averageRating}',
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
              margin: EdgeInsets.only(left: 8.w),
              child: Text('\$${shoe.price.toStringAsFixed(2)}',
                  style: bodyText400Dark.copyWith(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
