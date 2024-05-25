import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../const/img_asset.dart';

class KAddButton extends StatelessWidget {
 final VoidCallback onAdd;
  const KAddButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return                             InkWell(
        onTap: onAdd,
        child: SvgPicture.asset(ImageAsset.add,height:24.w ,width: 24.w,)
    );
  }
}
