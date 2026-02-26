import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    cardTheme: const CardThemeData(color: Colors.white),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    cardTheme: const CardThemeData(color: Color(0xFF1E1E1E)),
  );
}
