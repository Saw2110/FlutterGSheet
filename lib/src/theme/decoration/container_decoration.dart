import 'package:flutter/material.dart';

import '../colors.dart';

class ContainerDecoration {
  static decoration(
      {Color? color, Color? bColor, BorderRadiusGeometry? bRadius}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: bColor ?? borderColor),
      borderRadius: bRadius ?? BorderRadius.circular(5.0),
    );
  }
}
