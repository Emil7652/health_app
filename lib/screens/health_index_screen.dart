import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthIndexScreen extends StatelessWidget {
  const HealthIndexScreen({super.key});

  List<FlSpot> get _indexData => const [
    FlSpot(0, 68),
    FlSpot(1, 70),
    FlSpot(2, 72),
    FlSpot(3, 71),
    FlSpot(4, 74),
    FlSpot(5, 76),
    FlSpot(6, 78),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexData.last.y;

    return Scaffold(
      appBar: AppBar(title: const Text('Health Index')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Текущий индекс здоровья',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${currentIndex.toInt()}%',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Комплексная оценка состояния организма',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Динамика Health Index',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// 🔒 КЛЮЧЕВОЕ ИСПРАВЛЕНИЕ
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LineChart(_indexChart()),
                      ),
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

  LineChartData _indexChart() {
    return LineChartData(
      minY: 60,
      maxY: 85,
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _indexData,
          isCurved: true,
          barWidth: 3,
          color: Colors.green,
          dotData: const FlDotData(show: true),
        ),
      ],
    );
  }
}
