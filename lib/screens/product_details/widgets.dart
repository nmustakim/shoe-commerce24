import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rating.floor();
    List<Widget> starWidgets = [];

    for (int i = 0; i < numberOfStars; i++) {
      starWidgets.add(Icon(Icons.star, color: Colors.yellow, size: 16.sp));
    }

    if (rating - numberOfStars >= 0.5) {
      starWidgets.add(Icon(Icons.star_half, color: Colors.yellow, size: 16.sp));
    }

    return Row(children: starWidgets);
  }
}