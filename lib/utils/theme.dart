import 'package:flutter/material.dart';

import '../constant/colors.dart';

ThemeData darkTheme() => ThemeData(
    scaffoldBackgroundColor: DarkColors.background,
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: DarkColors.background,
      selectedIconTheme: IconThemeData(color: DarkColors.primary),
      unselectedIconTheme: IconThemeData(color: DarkColors.unselectedIcon),
    ),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: DarkColors.primary),
        headlineLarge: TextStyle(
            fontSize: 40,
            color: DarkColors.primary,
            fontWeight: FontWeight.w800)));
