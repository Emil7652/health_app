import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.grey.shade100,
  cardColor: Colors.white,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardColor: const Color(0xFF1E1E1E),
);

class ThemeProvider extends ChangeNotifier {
  bool _dark = false;
  bool _initialized = false;

  bool get initialized => _initialized;
  ThemeMode get mode => _dark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _dark = prefs.getBool('dark_theme') ?? false;
    _initialized = true;
    notifyListeners();
  }

  Future<void> toggle() async {
    _dark = !_dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_theme', _dark);
    notifyListeners();
  }
}
