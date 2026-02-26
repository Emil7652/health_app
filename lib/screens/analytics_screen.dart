import 'package:flutter/material.dart';
import '../widgets/analytics_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Аналитика ИИ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          AnalyticsCard(
            title: 'Сон',
            subtitle: 'Тренд за 7 дней',
            value: '7.4 ч',
          ),
          AnalyticsCard(
            title: 'Стресс',
            subtitle: 'Средний уровень',
            value: '62%',
          ),
          AnalyticsCard(
            title: 'Пульс',
            subtitle: 'Среднее значение',
            value: '72 bpm',
          ),
        ],
      ),
    );
  }
}
