import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/streak_service.dart';
import 'steps_screen.dart';
import 'stress_screen.dart';
import 'sleep_screen.dart';
import 'pulse_screen.dart';
import 'spo2_screen.dart';
import 'health_index_screen.dart';
import 'steps_goal_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final streak = context.watch<StreakService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LifePulse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StepsGoalScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StreakCard(streak: streak),
          const SizedBox(height: 16),

          _NavCard(
            title: 'Шаги',
            icon: Icons.directions_walk,
            screen: const StepsScreen(),
          ),
          _NavCard(
            title: 'Стресс',
            icon: Icons.psychology,
            screen: const StressScreen(),
          ),
          _NavCard(title: 'Сон', icon: Icons.bedtime, screen: SleepScreen()),
          _NavCard(
            title: 'Пульс',
            icon: Icons.favorite,
            screen: const PulseScreen(),
          ),
          _NavCard(
            title: 'SpO₂',
            icon: Icons.bloodtype,
            screen: const Spo2Screen(),
          ),
          _NavCard(
            title: 'Индекс здоровья',
            icon: Icons.insights,
            screen: const HealthIndexScreen(),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget screen;

  const _NavCard({
    required this.title,
    required this.icon,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final StreakService streak;

  const _StreakCard({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.local_fire_department,
              size: 48,
              color: streak.todayCompleted ? Colors.orange : Colors.grey,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Серия: ${streak.currentStreak} дней',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  streak.todayCompleted
                      ? 'Цель на сегодня выполнена'
                      : 'Цель на сегодня не выполнена',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
