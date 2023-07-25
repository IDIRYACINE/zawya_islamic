// ignore_for_file: unused_field

import 'package:flutter/material.dart';

abstract class AppThemes {
  static const _mainColor =   Color.fromARGB(255, 1, 11, 44); // ;//0x2A5390;
  static const _accentColor = Color.fromARGB(0, 70, 194, 203);

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        brightness: Brightness.dark,
        ),
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );

  static final lightTheme = ThemeData(
    dialogBackgroundColor: _mainColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: _mainColor
    ),
    colorScheme: ColorScheme.fromSeed(
        secondary: _accentColor,
        seedColor: _mainColor,
        brightness: Brightness.light,
        surface: _mainColor ,
        onSurface: Colors.white
        ),
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );
}
