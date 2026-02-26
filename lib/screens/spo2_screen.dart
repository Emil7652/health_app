import 'package:flutter/material.dart';

class Spo2Screen extends StatefulWidget {
  const Spo2Screen({super.key});

  @override
  State<Spo2Screen> createState() => _Spo2ScreenState();
}

class _Spo2ScreenState extends State<Spo2Screen> {
  late final List<Spo2Data> history;

  @override
  void initState() {
    super.initState();

    history = List.generate(7, (i) {
      return Spo2Data(
        date: DateTime.now().subtract(Duration(days: 6 - i)),
        value: 93 + (i % 4),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final avg =
        history.map((e) => e.value).reduce((a, b) => a + b) / history.length;

    return Scaffold(
      appBar: AppBar(title: const Text('SpO₂')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${avg.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              avg >= 95
                  ? 'Нормальная сатурация'
                  : 'Пониженная сатурация, рекомендуется контроль',
            ),
          ],
        ),
      ),
    );
  }
}

class Spo2Data {
  final DateTime date;
  final int value;

  Spo2Data({required this.date, required this.value});
}
