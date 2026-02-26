class HealthIndex {
  static double calculate({
    required double sleep,
    required double spo2,
    required double steps,
    required double stress,
    required double pulse,
  }) {
    return (sleep * 0.25 +
            spo2 * 0.2 +
            steps * 0.15 +
            (100 - stress) * 0.2 +
            (100 - (pulse - 60).abs()) * 0.2)
        .clamp(0, 100);
  }
}
