import 'package:shared_preferences/shared_preferences.dart';

class StepsStreakService {
  static const goal = 8000;

  Future<int> updateStreak(int todaySteps) async {
    final prefs = await SharedPreferences.getInstance();

    int streak = prefs.getInt('streak') ?? 0;
    int freeze = prefs.getInt('freeze') ?? 0;
    DateTime last =
        DateTime.tryParse(prefs.getString('last_date') ?? '') ??
        DateTime.now().subtract(const Duration(days: 1));

    final today = DateTime.now();
    final diff = today.difference(last).inDays;

    if (todaySteps >= goal) {
      streak += 1;
      freeze = 0;
    } else {
      freeze += diff;
      if (freeze > 3) {
        streak = 0;
        freeze = 0;
      }
    }

    prefs
      ..setInt('streak', streak)
      ..setInt('freeze', freeze)
      ..setString('last_date', today.toIso8601String());

    return streak;
  }

  Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('streak') ?? 0;
  }
}
