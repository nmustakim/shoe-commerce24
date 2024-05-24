import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/text_style.dart';

import '../../../const/img_asset.dart';
import '../../../models/review.dart';
import '../../../util/string_util.dart';


Widget buildReviewItem(Review review) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage:  AssetImage(ImageAsset.starBlank),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(review.username, style:bodyTextW700F14Dark),
                  Text(StringUtil.formattedDate(review.timestamp), style: bodyTextW400F12Light),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: List.generate(
                  5,
                      (index) {

                    return Container(
                      margin: EdgeInsets.only(right: 4.w),
                      child: Image.asset(
                        index < review.rating ? ImageAsset.starFilled : ImageAsset.starBlank,
                        height: 12.h,
                        width: 12.w,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h),
              Text(review.comment, style: bodyTextW400F12Dark.copyWith(height: 1.6666667)),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ],
    ),
  );
}
