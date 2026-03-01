import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _loggedIn = false;
  bool _initialized = false;

  bool get isLoggedIn => _loggedIn;
  bool get initialized => _initialized;

  AuthService() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool('logged_in') ?? false;
    _initialized = true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('logged_in', true);
      _loggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    _loggedIn = false;
    notifyListeners();
  }
}
