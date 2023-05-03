import 'package:flutter/material.dart';

const Color brandColor = Color(0xFF252aa1);
const Color brandSecondaryColor = Color(0xff3d4287);
const Color brandThirdColor = Color(0xff312b6b);


MaterialColor getMaterialColor(Color color) {
  final Map<int, Color> shade1 = {
    50: const Color.fromRGBO(37, 42, 161, .1),
    100: const Color.fromRGBO(37, 42, 161, .2),
    200: const Color.fromRGBO(37, 42, 161, .3),
    300: const Color.fromRGBO(37, 42, 161, .4),
    400: const Color.fromRGBO(37, 42, 161, .5),
    500: const Color.fromRGBO(37, 42, 161, .6),
    600: const Color.fromRGBO(37, 42, 161, .7),
    700: const Color.fromRGBO(37, 42, 161, .8),
    800: const Color.fromRGBO(37, 42, 161, .9),
    900: const Color.fromRGBO(37, 42, 161, 1.0),
  };
  return MaterialColor(color.value, shade1);
}
MaterialColor blackColor(Color color) {
  final Map<int, Color> shade = {
    50: const Color.fromRGBO(37, 42, 161, .1),
    100: const Color.fromRGBO(37, 42, 161, .2),
    200: const Color.fromRGBO(37, 42, 161, .3),
    300: const Color.fromRGBO(37, 42, 161, .4),
    400: const Color.fromRGBO(37, 42, 161, .5),
    500: const Color.fromRGBO(37, 42, 161, .6),
    600: const Color.fromRGBO(37, 42, 161, .7),
    700: const Color.fromRGBO(37, 42, 161, .8),
    800: const Color.fromRGBO(37, 42, 161, .9),
    900: const Color.fromRGBO(0, 0, 0, 1.0),
  };
  return MaterialColor(color.value, shade);
}
