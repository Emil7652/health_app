// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'dark_mode';

  bool _dark = false;
  bool initialized = false;

  ThemeMode get mode => _dark ? ThemeMode.dark : ThemeMode.light;
  bool get isDark => _dark;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _dark = prefs.getBool(_key) ?? false;
    initialized = true;
    notifyListeners();
  }

  Future<void> toggle() async {
    _dark = !_dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _dark);
    notifyListeners();
  }
}

/// 🎨 Светлая тема
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorSchemeSeed: Colors.blueAccent,
);

/// 🌙 Тёмная тема
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorSchemeSeed: Colors.blueAccent,
);
