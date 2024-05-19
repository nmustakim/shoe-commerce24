import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_commerce/const/color.dart';

import '../../../model/shoe.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;
  final int index;

  const ShoeCard({super.key, required this.shoe, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.h,
          width: 150.h,
          child: Card(
            color: productBackground,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),

            ),
            child: Image.asset(shoe.image),

          ),
        ),

        Text(shoe.title,
            style:
                GoogleFonts.urbanist().copyWith(fontWeight: FontWeight.w400)),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
            Text('${shoe.rating} ★ ${shoe.reviewCount} Reviews',
                style: TextStyle(fontSize: 12.sp)),
          ],
        ),
        Text('\$${shoe.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16.sp)),
      ],
    );
  }
}
