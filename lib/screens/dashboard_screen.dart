import 'package:flutter/material.dart';

import '../widgets/streak_widget.dart';
import 'analytics_screen.dart';
import 'health_index_screen.dart';
import 'sleep_screen.dart';
import 'pulse_screen.dart';
import 'spo2_screen.dart';
import 'steps_screen.dart';
import 'stress_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Здоровье'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 🔥 STREAK
            const StreakWidget(),

            const SizedBox(height: 24),

            // 📊 HEALTH INDEX
            _BigCard(
              title: 'Индекс здоровья',
              subtitle: 'Общий показатель',
              icon: Icons.favorite,
              color: Colors.pinkAccent,
              onTap: () => _open(context, const HealthIndexScreen()),
            ),

            const SizedBox(height: 24),

            // 🧩 GRID
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.05,
              ),
              children: [
                _SmallCard(
                  title: 'Шаги',
                  icon: Icons.directions_walk,
                  color: Colors.blue,
                  onTap: () => _open(context, StepsScreen()),
                ),
                _SmallCard(
                  title: 'Сон',
                  icon: Icons.bedtime,
                  color: Colors.indigo,
                  onTap: () => _open(context, SleepScreen()),
                ),
                _SmallCard(
                  title: 'Пульс',
                  icon: Icons.monitor_heart,
                  color: Colors.redAccent,
                  onTap: () => _open(context, PulseScreen()),
                ),
                _SmallCard(
                  title: 'SpO₂',
                  icon: Icons.bloodtype,
                  color: Colors.teal,
                  onTap: () => _open(context, Spo2Screen()),
                ),
                _SmallCard(
                  title: 'Стресс',
                  icon: Icons.self_improvement,
                  color: Colors.orange,
                  onTap: () => _open(context, StressScreen()),
                ),
                _SmallCard(
                  title: 'Аналитика',
                  icon: Icons.analytics,
                  color: Colors.deepPurple,
                  onTap: () => _open(context, AnalyticsScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

//
// ──────────────────────────────────────────────────────────────
//

class _BigCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _BigCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 56, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 32),
          ],
        ),
      ),
    );
  }
}

//
// ──────────────────────────────────────────────────────────────
//

class _SmallCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SmallCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
