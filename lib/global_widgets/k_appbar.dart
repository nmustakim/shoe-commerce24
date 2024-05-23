import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/global_widgets/k_star-filled.dart';

import '../const/text_style.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTrailingTap;
  final bool hasTrailing;
  final bool? hasTitle;
  final String? title;
  final String? rating;
  final bool? isReviewScreen;

  final bool? isDiscoverScreen;
  const KAppBar(
      {super.key,
      this.hasTrailing = false,
      this.isDiscoverScreen,
      this.onTrailingTap,
      this.hasTitle,
      this.title,
      this.isReviewScreen,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      centerTitle: isDiscoverScreen == true ? false : true,
      title: hasTitle == true
          ? Text(title!,
              style: isDiscoverScreen == true
                  ? headlineW700F18Dark
                  : headlineW600F16)
          : null,
      actions: [
        if (hasTrailing)
          Container(
              margin: EdgeInsets.only(right: 16.w),
              child: isReviewScreen == true
                  ? Row(
                      children: [
                        const KStarFilled(
                          isBigStar: true,
                        ),
                        Text(
                          rating!,
                          style: bodyTextW700F14Dark,
                        )
                      ],
                    )
                  : InkWell(
                      onTap: onTrailingTap,
                      child: Image.asset(isDiscoverScreen == true
                          ? 'assets/images/cart.png'
                          : 'assets/images/bag-2.png'))),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
