import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // DEMO login
    if (email.isNotEmpty && password.isNotEmpty) {
      _loggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
