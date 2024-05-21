import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/text_style.dart';

class KButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const KButton({
    super.key,
    required this.text,
    required this.onPressed, this.backgroundColor, this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
          backgroundColor: backgroundColor??Colors.black,
          foregroundColor: foregroundColor??Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          text,
          style:buttonTextStyle
        ),
      ),
    );
  }
}
