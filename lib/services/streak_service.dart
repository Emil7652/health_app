import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService extends ChangeNotifier {
  static const _streakKey = 'streak_count';
  static const _lastDayKey = 'last_active_day';
  static const _freezeKey = 'freeze_days';

  int _streak = 0;
  int _freezeDays = 0;
  DateTime? _lastDay;

  int get streak => _streak;
  int get freezeDays => _freezeDays;

  /// 🔄 загрузка сохранённых данных
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    _streak = prefs.getInt(_streakKey) ?? 0;
    _freezeDays = prefs.getInt(_freezeKey) ?? 0;

    final last = prefs.getString(_lastDayKey);
    if (last != null) {
      _lastDay = DateTime.parse(last);
    }

    _checkStreak();
    notifyListeners();
  }

  /// ✅ вызываем, когда цель шагов выполнена
  Future<void> completeDay() async {
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();

    if (_lastDay == null || !_isSameDay(now, _lastDay!)) {
      _streak++;
      _freezeDays = 0;
      _lastDay = now;

      await prefs.setInt(_streakKey, _streak);
      await prefs.setInt(_freezeKey, _freezeDays);
      await prefs.setString(_lastDayKey, now.toIso8601String());

      notifyListeners();
    }
  }

  /// ❄️ вызываем, если цель не выполнена
  Future<void> missDay() async {
    _freezeDays++;

    if (_freezeDays > 3) {
      _streak = 0;
      _freezeDays = 0;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_streakKey, _streak);
    await prefs.setInt(_freezeKey, _freezeDays);

    notifyListeners();
  }

  /// 🔍 проверка при запуске
  void _checkStreak() {
    if (_lastDay == null) return;

    final diff = DateTime.now().difference(_lastDay!).inDays;

    if (diff == 1) {
      _freezeDays++;
    } else if (diff > 1) {
      _streak = 0;
      _freezeDays = 0;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
