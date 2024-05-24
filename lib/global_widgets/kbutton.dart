import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/text_style.dart';

class KButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final bool? hasLeading;

  const KButton({
    super.key,
    required this.text,
    required this.onPressed, this.backgroundColor, this.foregroundColor,  this.height,  this.width, this.hasLeading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
           backgroundColor: backgroundColor??Colors.black,
          foregroundColor: foregroundColor??Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          text,
          style:buttonTextStyle1.copyWith(color: foregroundColor)
        ),
      ),
    );
  }
}
