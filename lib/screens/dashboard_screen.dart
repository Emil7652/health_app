import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/streak_service.dart';
import '../theme/app_theme.dart';
import '../auth/auth_service.dart';

import 'steps_screen.dart';
import 'sleep_screen.dart';
import 'spo2_screen.dart';
import 'pulse_screen.dart';
import 'stress_screen.dart';
import 'health_index_screen.dart';
import 'steps_goal_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final streak = context.watch<StreakService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Здоровье'),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggle();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthService>().logout(),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E2C), Color(0xFF23243A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StreakCard(streak),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _card(
                  context,
                  'Шаги',
                  Icons.directions_walk,
                  const StepsScreen(),
                ),
                _card(context, 'Сон', Icons.bed, SleepScreen()),
                _card(context, 'SpO₂', Icons.bloodtype, const Spo2Screen()),
                _card(context, 'Пульс', Icons.favorite, const PulseScreen()),
                _card(
                  context,
                  'Стресс',
                  Icons.psychology,
                  const StressScreen(),
                ),
                _card(
                  context,
                  'Индекс',
                  Icons.insights,
                  const HealthIndexScreen(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.flag),
              label: const Text('Цель шагов'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StepsGoalScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final StreakService streak;
  const _StreakCard(this.streak);

  @override
  Widget build(BuildContext context) {
    final completed = streak.completedToday;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: completed
              ? [Colors.orange, Colors.deepOrange]
              : [Colors.blueGrey, Colors.black45],
        ),
      ),
      child: Row(
        children: [
          AnimatedScale(
            scale: completed ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: const Icon(
              Icons.local_fire_department,
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Серия: ${streak.days} дней',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                completed
                    ? 'Сегодня выполнено'
                    : 'Можно заморозить (${streak.freezeDays}/3)',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
