import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService extends ChangeNotifier {
  int _currentStreak = 0;
  bool _todayCompleted = false;

  int get currentStreak => _currentStreak;
  bool get todayCompleted => _todayCompleted;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _currentStreak = prefs.getInt('streak_days') ?? 0;
    _todayCompleted = prefs.getBool('streak_today') ?? false;
    notifyListeners();
  }

  Future<void> completeToday() async {
    if (_todayCompleted) return;

    _todayCompleted = true;
    _currentStreak++;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak_days', _currentStreak);
    await prefs.setBool('streak_today', true);

    notifyListeners();
  }

  Future<void> resetIfMissed() async {
    final prefs = await SharedPreferences.getInstance();
    _currentStreak = 0;
    _todayCompleted = false;
    await prefs.setInt('streak_days', 0);
    await prefs.setBool('streak_today', false);
    notifyListeners();
  }
}
