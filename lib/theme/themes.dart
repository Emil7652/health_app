// lib/theme/themes.dart
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorSchemeSeed: Colors.teal,
  scaffoldBackgroundColor: const Color(0xFFF6F7F9),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontWeight: FontWeight.w600),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorSchemeSeed: Colors.teal,
  scaffoldBackgroundColor: const Color(0xFF0F1115),
);
