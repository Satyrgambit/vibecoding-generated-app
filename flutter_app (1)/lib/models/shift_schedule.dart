class ShiftSchedule {
  final String shiftId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String shiftType;

  ShiftSchedule({
    required this.shiftId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.shiftType,
  });

  ShiftSchedule copyWith({
    String? shiftId,
    String? userId,
    DateTime? startTime,
    DateTime? endTime,
    String? shiftType,
  }) {
    return ShiftSchedule(
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      shiftType: shiftType ?? this.shiftType,
    );
  }
}
