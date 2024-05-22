import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtil{
  static Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return const Color(0XFFE7E7E7);
      case 'red':
        return Colors.red;
      case 'blue':
        return const Color(0XFF2952CC);
      case 'green':
        return const Color(0XFF648B8B);
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}