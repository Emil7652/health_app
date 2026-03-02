import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService extends ChangeNotifier {
  int _days = 0;
  int _freezeDays = 0;
  DateTime? _lastCompleted;

  int get days => _days;
  int get freezeDays => _freezeDays;

  bool get completedToday {
    if (_lastCompleted == null) return false;
    final now = DateTime.now();
    return _lastCompleted!.year == now.year &&
        _lastCompleted!.month == now.month &&
        _lastCompleted!.day == now.day;
  }

  /// загрузка при старте
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _days = prefs.getInt('streak_days') ?? 0;
    _freezeDays = prefs.getInt('freeze_days') ?? 0;

    final last = prefs.getString('last_completed');
    if (last != null) {
      _lastCompleted = DateTime.parse(last);
    }
    notifyListeners();
  }

  /// отметить день выполненным
  Future<void> completeToday() async {
    if (completedToday) return;

    final now = DateTime.now();

    if (_lastCompleted != null) {
      final diff = now.difference(_lastCompleted!).inDays;

      if (diff == 1) {
        _days++;
      } else if (diff > 1) {
        if (_freezeDays < 3) {
          _freezeDays++;
        } else {
          _days = 1;
          _freezeDays = 0;
        }
      }
    } else {
      _days = 1;
    }

    _lastCompleted = now;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak_days', _days);
    await prefs.setInt('freeze_days', _freezeDays);
    await prefs.setString('last_completed', now.toIso8601String());

    notifyListeners();
  }
}
