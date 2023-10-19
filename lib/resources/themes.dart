// ignore_for_file: unused_field

import 'package:flutter/material.dart';

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.white,
  brightness: Brightness.dark,
);

final lightColorScheme = ColorScheme.fromSeed(
    secondaryContainer: AppThemes.accentColor,
    seedColor: AppThemes.mainColor,
    brightness: Brightness.light,
    surface: AppThemes.mainColor,
    onSurface: Colors.white);

abstract class AppThemes {
  static const mainColor = Color.fromARGB(255, 1, 11, 44); // ;//0x2A5390;
  static const accentColor = Colors.lightBlueAccent;

  static final darkTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkColorScheme.onSurface,
      selectionColor: Colors.white.withOpacity(0.4),
      selectionHandleColor: darkColorScheme.secondary,
    ),
    colorScheme: darkColorScheme,
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );

  static final lightTheme = ThemeData(
    dialogBackgroundColor: mainColor,
    primarySwatch: Colors.red,
    hintColor: Colors.grey,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.grey, backgroundColor: mainColor),
    colorScheme: lightColorScheme,
    useMaterial3: true,
    fontFamily: 'ArabicModern',
  );
}
