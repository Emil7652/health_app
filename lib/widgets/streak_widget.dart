import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/streak_service.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final streak = context.watch<StreakService>();

    return AnimatedScale(
      scale: streak.isFrozen ? 0.95 : 1.05,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: streak.isFrozen
                ? [Colors.blueGrey, Colors.blueGrey.shade700]
                : [Colors.orange, Colors.redAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              streak.isFrozen ? Icons.ac_unit : Icons.local_fire_department,
              color: Colors.white,
              size: 36,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${streak.streak} дней подряд',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (streak.isFrozen)
                  Text(
                    'Заморозка: ${streak.freezeDays}/3',
                    style: const TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
