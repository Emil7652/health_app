import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService extends ChangeNotifier {
  static const _stepsGoal = 8000;

  int _streak = 0;
  int _freezeDays = 0;
  DateTime? _lastActiveDay;

  int get streak => _streak;
  int get freezeDays => _freezeDays;
  bool get isFrozen => _freezeDays > 0;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _streak = prefs.getInt('streak') ?? 0;
    _freezeDays = prefs.getInt('freezeDays') ?? 0;

    final last = prefs.getString('lastActiveDay');
    if (last != null) {
      _lastActiveDay = DateTime.parse(last);
      _checkMissedDays();
    }

    notifyListeners();
  }

  Future<void> updateSteps(int todaySteps) async {
    if (todaySteps < _stepsGoal) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (_lastActiveDay == today) return;

    _streak++;
    _freezeDays = 0;
    _lastActiveDay = today;

    await _save();
    notifyListeners();
  }

  void _checkMissedDays() {
    if (_lastActiveDay == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(_lastActiveDay!).inDays;

    if (diff == 0) return;

    if (diff <= 3) {
      _freezeDays = diff;
    } else {
      _streak = 0;
      _freezeDays = 0;
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', _streak);
    await prefs.setInt('freezeDays', _freezeDays);
    await prefs.setString('lastActiveDay', _lastActiveDay!.toIso8601String());
  }
}
