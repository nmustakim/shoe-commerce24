import 'package:flutter/material.dart';
import 'package:shoe_commerce/global_widgets/k_star-filled.dart';
import 'package:shoe_commerce/global_widgets/k_star_blank.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rating.floor();
    List<Widget> starWidgets = [];

    for (int i = 0; i < numberOfStars; i++) {
      starWidgets.add(
     const KStarFilled()
      );
    }

    if (rating - numberOfStars >= 0.5) {
      starWidgets.add(
        const KStarBlank()
      );
    }

    return Row(

        children: starWidgets);
  }
}
