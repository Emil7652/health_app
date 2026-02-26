class RecommendationEngine {
  static String sleep(double avgSleep) {
    if (avgSleep >= 8) {
      return 'Отличный режим сна. Организм полностью восстанавливается.';
    } else if (avgSleep >= 7) {
      return 'Хороший сон, но стоит стремиться к 8 часам.';
    } else if (avgSleep >= 6) {
      return 'Недостаточный сон. Рекомендуется ложиться раньше.';
    } else {
      return 'Хронический недосып. Повышенный риск снижения концентрации.';
    }
  }
}
