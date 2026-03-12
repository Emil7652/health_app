import 'package:flutter/material.dart';
import 'package:health_app/screens/profile_screen.dart';
import 'package:health_app/screens/steps_goal_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/streak_widget.dart';
import '../auth/auth_service.dart';
import '../theme/app_theme.dart';

import 'steps_screen.dart';
import 'stress_screen.dart';
import 'pulse_screen.dart';
import 'sleep_screen.dart';
import 'spo2_screen.dart';
import 'analytics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final auth = context.read<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Обзор здоровья'),

        /// ✅ КНОПКИ СПРАВА (ТОЛЬКО ИХ И МЕНЯЛИ)
        actions: [
          /// 🌗 Переключение темы
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),

          /// 🚪 Выход
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthService>().logout();
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 STREAK
            const StreakWidget(),
            const SizedBox(height: 24),

            /// 📊 Основные показатели
            Text(
              'Основные показатели',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _DashboardCard(
                  title: 'Шаги',
                  value: '8 420',
                  unit: '',
                  icon: Icons.directions_walk,
                  color: Colors.blue,
                  screen: StepsScreen(),
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StepsGoalScreen(),
                      ),
                    );
                  },
                ),
                _DashboardCard(
                  title: 'Пульс',
                  value: '72',
                  unit: 'уд/мин',
                  icon: Icons.favorite,
                  color: Colors.redAccent,
                  screen: PulseScreen(),
                ),
                _DashboardCard(
                  title: 'Стресс',
                  value: '62%',
                  unit: '',
                  icon: Icons.self_improvement,
                  color: Colors.orange,
                  screen: StressScreen(),
                ),
                _DashboardCard(
                  title: 'Сон',
                  value: '7.4',
                  unit: 'часа',
                  icon: Icons.bedtime,
                  color: Colors.indigo,
                  screen: SleepScreen(),
                ),
                _DashboardCard(
                  title: 'SpO₂',
                  value: '98%',
                  unit: '',
                  icon: Icons.bloodtype,
                  color: Colors.green,
                  screen: Spo2Screen(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// 📈 Аналитика
            Text(
              'Аналитика',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _WideAnalyticsCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Widget screen;
  final VoidCallback? onLongPress;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.screen,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      onLongPress: title == 'Шаги'
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StepsGoalScreen()),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 34, color: color),

            const Spacer(), // ✅ ВМЕСТО Expanded

            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              unit,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _WideAnalyticsCard extends StatelessWidget {
  final VoidCallback onTap;

  const _WideAnalyticsCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.show_chart, color: Colors.white, size: 40),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Посмотреть аналитику за 7 дней',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
