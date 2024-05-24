import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/img_asset.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          return Container(
            margin: EdgeInsets.only(right: 4.w),
            child: SvgPicture.asset(
              index < rating ? ImageAsset.starFilled : ImageAsset.starBlank,
              height: 12.h,
              width: 12.w,
            ),
          );
        },
      ),
    );
  }
}
