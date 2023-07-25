// ignore_for_file: unused_field

import 'package:flutter/material.dart';

abstract class AppThemes {
  static const _mainColor = 0x0D1F47;
  static const _accentColor = 0x46C2CB;

  static final darkTheme = ThemeData(
    colorSchemeSeed: const Color(_mainColor),
    useMaterial3: false,
    brightness: Brightness.dark,
    fontFamily: 'ArabicModern',
  );

  static final lightTheme = ThemeData(
    colorSchemeSeed: const Color(_accentColor),
    brightness: Brightness.light,
    fontFamily: 'ArabicModern',
  );
}
