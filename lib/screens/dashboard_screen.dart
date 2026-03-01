import 'package:flutter/material.dart';
import '../widgets/streak_widget.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Обзор здоровья'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
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
                const _DashboardCard(
                  title: 'Шаги',
                  value: '8 420',
                  unit: 'шагов',
                  icon: Icons.directions_walk,
                  color: Colors.blue,
                  screen: StepsScreen(),
                ),
                const _DashboardCard(
                  title: 'Пульс',
                  value: '72',
                  unit: 'уд/мин',
                  icon: Icons.favorite,
                  color: Colors.redAccent,
                  screen: PulseScreen(),
                ),
                const _DashboardCard(
                  title: 'Стресс',
                  value: '62%',
                  unit: 'уровень',
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
                const _DashboardCard(
                  title: 'SpO₂',
                  value: '98%',
                  unit: 'кислород',
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

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        padding: const EdgeInsets.all(18),
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
            Hero(
              tag: title,
              child: Icon(icon, size: 36, color: color),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              unit,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 6),
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
