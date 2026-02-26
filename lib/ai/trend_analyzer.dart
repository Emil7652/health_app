enum TrendType { up, down, stable }

class TrendAnalyzer {
  static TrendType analyze(List<double> values) {
    if (values.length < 2) return TrendType.stable;

    final first = values.first;
    final last = values.last;

    if (last > first) return TrendType.up;
    if (last < first) return TrendType.down;
    return TrendType.stable;
  }

  static String trendText(TrendType trend) {
    switch (trend) {
      case TrendType.up:
        return 'Положительная динамика';
      case TrendType.down:
        return 'Отрицательная динамика';
      case TrendType.stable:
        return 'Стабильное состояние';
    }
  }
}
