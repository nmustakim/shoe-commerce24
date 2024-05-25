import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/k_star-filled.dart';

import '../../../models/shoe.dart';

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
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Card(
                  color: secondaryBackgroundWhite1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: CachedNetworkImage(
                        imageUrl: shoe.images.first,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(height:40.h,color: Colors.white),
                        ), // Placeholder widget
                        errorWidget: (context, url, error) =>
                             Icon(Icons.error,size:10.sp),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24.w, top: 30.h),
                  child: CachedNetworkImage(
                    // Use CachedNetworkImage widget
                    imageUrl: shoe.logo,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                         Icon(Icons.error,size: 10.sp,),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(shoe.name, style: bodyTextW400F12Dark),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 6.w),
            child: Row(
              children: [
                const KStarFilled(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${shoe.averageRating}',
                        style: bodyTextW700F11Dark,
                      ),
                      TextSpan(
                        text: ' (${shoe.reviewCount} Reviews)',
                        style: bodyTextW400F12Light,
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
                  style: bodyTextW700F14Dark),
            ),
          ),
        ],
      ),
    );
  }
}
