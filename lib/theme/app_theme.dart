import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'dark_theme';

  bool _dark = false;
  bool initialized = false;

  bool get isDark => _dark;

  ThemeMode get mode => _dark ? ThemeMode.dark : ThemeMode.light;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _dark = prefs.getBool(_key) ?? false;
    initialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _dark = !_dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _dark);
    notifyListeners();
  }
}
