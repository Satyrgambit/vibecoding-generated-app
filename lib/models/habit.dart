class Habit {
  final String habitId;
  final String userId;
  final String title;
  final String description;
  final String frequency;
  final bool shiftAligned;

  Habit({
    required this.habitId,
    required this.userId,
    required this.title,
    required this.description,
    required this.frequency,
    required this.shiftAligned,
  });

  Habit copyWith({
    String? habitId,
    String? userId,
    String? title,
    String? description,
    String? frequency,
    bool? shiftAligned,
  }) {
    return Habit(
      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      shiftAligned: shiftAligned ?? this.shiftAligned,
    );
  }
}
