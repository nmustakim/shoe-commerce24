import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/text_style.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTrailingTap;
  final bool hasTrailing;
  final bool? hasTitle;
  final String? title;

  final bool? isDiscoverScreen;
  const KAppBar(
      {super.key,
      this.hasTrailing = false,
       this.isDiscoverScreen,
       this.onTrailingTap,  this.hasTitle, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      centerTitle: isDiscoverScreen == true?false:true,
      title: hasTitle==true ? Text(title!, style: isDiscoverScreen==true?headline700Big:headline600small) : null,
      actions: [
        if (hasTrailing)
          Container(
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                  onTap: onTrailingTap,
                  child: Image.asset(isDiscoverScreen==true
                      ? 'assets/images/cart.png'
                      : 'assets/images/bag-2.png'))),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
