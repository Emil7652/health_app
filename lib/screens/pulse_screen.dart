import 'package:flutter/material.dart';
import '../widgets/analytics_card.dart';
import '../widgets/simple_line_chart.dart';

class PulseScreen extends StatelessWidget {
  const PulseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final values = [72, 74, 71, 73, 75, 70, 72];

    return Scaffold(
      appBar: AppBar(title: const Text('Пульс')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnalyticsCard(
          title: 'Пульс',
          subtitle: 'За последние 7 дней',
          value: '72 bpm',
          chart: SimpleLineChart(values: values, color: Colors.red),
        ),
      ),
    );
  }
}
