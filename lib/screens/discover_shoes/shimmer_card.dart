import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/color.dart';

class ShoeCardShimmer extends StatelessWidget {
  const ShoeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.h,
            width: 160.w,
            child: Card(
              color: secondaryBackground1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            width: 160.w,
            height: 12.h,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 11.h,
          ),
          Row(
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
          SizedBox(height: 4.h),
          Container(
            width: 60.w,
            height: 12.h,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
