import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Spo2Screen extends StatelessWidget {
  Spo2Screen({super.key});

  final List<double> sleepHours = [100, 98, 99, 100, 95, 97, 100];

  @override
  Widget build(BuildContext context) {
    final avgSleep = sleepHours.reduce((a, b) => a + b) / sleepHours.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Сатурация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(
              title: 'Средняя сатурация',
              value: '${avgSleep.toStringAsFixed(1)} %',
              subtitle: avgSleep >= 7
                  ? 'Хороший уровень сатурации'
                  : 'Слишком низкая сатурация, рекомендуется обратиться к врачу ',
            ),
            const SizedBox(height: 16),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Динамика средней сатурации за неделю',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    AspectRatio(
                      aspectRatio: 1.6,
                      child: LineChart(_sleepChart()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(subtitle),
          ],
        ),
      ),
    );
  }

  LineChartData _sleepChart() {
    return LineChartData(
      minY: 90,
      maxY: 110,
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
              return Text(days[value.toInt() % 7]);
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            sleepHours.length,
            (i) => FlSpot(i.toDouble(), sleepHours[i]),
          ),
          isCurved: true,
          barWidth: 3,
          dotData: FlDotData(show: true),
        ),
      ],
    );
  }
}
