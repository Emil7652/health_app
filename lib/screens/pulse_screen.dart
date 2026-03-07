import 'package:flutter/material.dart';

class PulseScreen extends StatelessWidget {
  const PulseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Пульс"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// CURRENT VALUE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(Icons.favorite, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "72",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "bpm",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Нормальный уровень",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// GRAPH CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "График за 7 дней",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  /// Fake graph placeholder
                  SizedBox(
                    height: 120,
                    child: Center(child: Text("Здесь будет график")),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// STATS
            Row(
              children: [
                Expanded(
                  child: _StatCard(title: "Средний", value: "72", unit: "bpm"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(title: "Макс", value: "102", unit: "bpm"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(title: "Мин", value: "62", unit: "bpm"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(unit, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
