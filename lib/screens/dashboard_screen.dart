import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import 'analytics_screen.dart';
import 'health_index_screen.dart';
import 'sleep_screen.dart';
import 'pulse_screen.dart';
import 'spo2_screen.dart';
import 'steps_screen.dart';
import 'stress_screen.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const DashboardScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Панель здоровья'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthService>().logout();
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _card(
            context,
            'Индекс',
            Icons.health_and_safety,
            Colors.green,
            HealthIndexScreen(),
          ),
          _card(context, 'Сон', Icons.bedtime, Colors.indigo, SleepScreen()),
          _card(context, 'Пульс', Icons.favorite, Colors.red, PulseScreen()),
          _card(
            context,
            'SpO₂',
            Icons.bloodtype,
            Colors.deepPurple,
            Spo2Screen(),
          ),
          _card(
            context,
            'Шаги',
            Icons.directions_walk,
            Colors.orange,
            StepsScreen(),
          ),
          _card(
            context,
            'Стресс',
            Icons.self_improvement,
            Colors.blueGrey,
            StressScreen(),
          ),
          _card(
            context,
            'Аналитика ИИ',
            Icons.analytics,
            Colors.teal,
            AnalyticsScreen(),
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Ink(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
