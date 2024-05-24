import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_commerce/const/img_asset.dart';

class KStarFilled extends StatelessWidget {
  final bool isBigStar;
   const KStarFilled({super.key,  this.isBigStar=false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 4.w),
        child: SvgPicture.asset(
          ImageAsset.starFilled,
          height: isBigStar?20.h:12.h,
          width:isBigStar?20.w: 12.w,
        ));
  }
}
