// ignore_for_file: unused_field

import 'package:flutter/material.dart';

abstract class AppThemes {
  static const mainColor =   Color.fromARGB(255, 1, 11, 44); // ;//0x2A5390;
  static const accentColor =  Colors.lightBlueAccent;

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        brightness: Brightness.dark,
        ),
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );

  static final lightTheme = ThemeData(
    dialogBackgroundColor: mainColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: mainColor
    ),
    colorScheme: ColorScheme.fromSeed(
        secondaryContainer: accentColor,

        seedColor: mainColor,
        brightness: Brightness.light,
        surface: mainColor ,
        onSurface: Colors.white
        ),
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );
}
