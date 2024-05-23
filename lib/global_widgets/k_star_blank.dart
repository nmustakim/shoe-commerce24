import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class  KStarBlank extends StatelessWidget {
  const KStarBlank({super.key});


  @override
  Widget build(BuildContext context) {
    return         Container(
        margin: EdgeInsets.only(right: 4.w),
        child: Image.asset(
          'assets/images/star-blank.png',
          height: 12.h,
          width: 12.w,
        )
    );
  }
}
