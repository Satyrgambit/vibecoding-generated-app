class HabitLog {
  final String logId;
  final String habitId;
  final DateTime date;
  final bool completed;

  HabitLog({
    required this.logId,
    required this.habitId,
    required this.date,
    required this.completed,
  });

  HabitLog copyWith({
    String? logId,
    String? habitId,
    DateTime? date,
    bool? completed,
  }) {
    return HabitLog(
      logId: logId ?? this.logId,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }
}
