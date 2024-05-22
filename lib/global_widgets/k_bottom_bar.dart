import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';


class KBottomBar extends StatelessWidget {
  final String labelText;
  final String valueText;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const KBottomBar({
    super.key,
    required this.labelText,
    required this.valueText,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText, style: bodyTextW400F12Light),
            Text(valueText, style: bodyTextW700F20Dark),
          ],
        ),
        KButton(
          height: 50.h,
          width: 156.w,
          text: buttonText,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
