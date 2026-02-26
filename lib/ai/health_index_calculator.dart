double calculateHealthIndex({
  required double sleep,
  required double spo2,
  required double steps,
  required double stress,
  required double pulse,
}) {
  return (sleep * 0.25 +
      spo2 * 0.20 +
      steps * 0.15 +
      (100 - stress) * 0.15 +
      pulse * 0.15);
}
