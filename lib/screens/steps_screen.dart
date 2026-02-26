import 'package:flutter/material.dart';
import '../models/steps_data.dart';

class StepsScreen extends StatelessWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      StepsData(DateTime.now().subtract(const Duration(days: 2)), 6200),
      StepsData(DateTime.now().subtract(const Duration(days: 1)), 8300),
      StepsData(DateTime.now(), 9400),
    ];

    final avg = data.map((e) => e.steps).reduce((a, b) => a + b) / data.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Steps')),
      body: Center(
        child: Text(
          'Average steps: ${avg.round()}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
