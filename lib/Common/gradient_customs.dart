import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:flutter/material.dart';

class GradientCustom {}

Gradient gradientBlanckAll() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment(0, 1),
    colors: <Color>[
      Colors.black,
      Colors.black,
      Colors.black,
    ],
    tileMode: TileMode.mirror,
  );
}

Gradient gradientTreeColors() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromARGB(255, 206, 177, 81),
      ColorPalette.activeSwitch,
      Color.fromARGB(255, 157, 122, 8),
    ],
    tileMode: TileMode.mirror,
  );
}
