import 'dart:ui';

import 'package:flutter/material.dart';

class TextStyleCustom {}

TextStyle styleCustomGoodTimesWhite() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}

TextStyle styleCustomGoodTimes() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

TextStyle styleCustomGoodTimesBold() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 18.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle styleGoodTimes14WhiteBold() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 14.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

TextStyle styleGoodTimes24BlackBold() {
  return const TextStyle(
    fontFamily: 'GoodTimes',
    fontSize: 24.0,
    wordSpacing: 1,
    letterSpacing: 0.001,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
