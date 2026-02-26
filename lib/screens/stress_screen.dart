import 'package:flutter/material.dart';
import '../models/stress_data.dart';

class StressScreen extends StatelessWidget {
  const StressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      StressData(DateTime.now().subtract(const Duration(days: 2)), 40),
      StressData(DateTime.now().subtract(const Duration(days: 1)), 65),
      StressData(DateTime.now(), 55),
    ];

    final avg = data.map((e) => e.level).reduce((a, b) => a + b) / data.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Stress')),
      body: Center(
        child: Text(
          'Average stress level: ${avg.round()}%',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
