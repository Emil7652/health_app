void checkPulse(double pulse, double stress) {
  if (pulse > 95) {
    sendNotification(
      'High heart rate',
      'Your pulse is elevated. Consider resting.',
    );
  }

  if (pulse > 90 && stress > 70) {
    sendNotification('Stress overload', 'High stress and heart rate detected.');
  }
}
