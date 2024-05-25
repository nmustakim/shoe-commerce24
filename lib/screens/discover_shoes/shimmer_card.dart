import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/color.dart';

class ShoeCardShimmer extends StatelessWidget {
  const ShoeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                color: secondaryBackgroundWhite1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 150.w,
              height: 12.h,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    width: 100.w,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 60.w,
              height: 12.h,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16.h,)
          ],
        ),
      ),
    );
  }
}
