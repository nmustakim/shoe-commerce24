import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../const/img_asset.dart';

class KRemoveButton extends StatelessWidget {
  final VoidCallback onRemove;
  const KRemoveButton({super.key, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onRemove,
        child: SvgPicture.asset(
          ImageAsset.remove,
          height: 24.w,
          width: 24.w,
        ));
  }
}
