import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/text_style.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final bool hasTrailing;
  final bool isDiscoverScreen;
  const KAppBar(
      {super.key,
      this.hasTrailing = false,
      required this.isDiscoverScreen,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      title: isDiscoverScreen ? Text('Discover', style: headline700) : null,
      actions: [
        if (hasTrailing)
          Container(
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                  onTap: onTap,
                  child: Image.asset(isDiscoverScreen
                      ? 'assets/images/cart.png'
                      : 'assets/images/bag-2.png'))),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
