import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<int> values;
  final Color color;

  const SimpleLineChart({super.key, required this.values, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ChartPainter(values, color));
  }
}

class _ChartPainter extends CustomPainter {
  final List<int> values;
  final Color color;

  _ChartPainter(this.values, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final maxVal = values.reduce((a, b) => a > b ? a : b).toDouble();
    final minVal = values.reduce((a, b) => a < b ? a : b).toDouble();

    final dx = size.width / (values.length - 1);

    final path = Path();

    for (int i = 0; i < values.length; i++) {
      final x = dx * i;
      final y =
          size.height -
          ((values[i] - minVal) / (maxVal - minVal + 0.01)) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
