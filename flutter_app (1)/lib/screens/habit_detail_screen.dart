import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shift_habit/models/habit.dart';
import 'package:shift_habit/models/habit_log.dart';
import 'package:uuid/uuid.dart';

class HabitDetailScreen extends StatefulWidget {
  const HabitDetailScreen({Key? key}) : super(key: key);

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  late Habit habit;
  final List<HabitLog> _logs = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Habit) {
      habit = args;
    }
  }

  void _toggleCompletion(DateTime date) {
    final index = _logs.indexWhere((log) => isSameDate(log.date, date));
    setState(() {
      if (index == -1) {
        _logs.add(HabitLog(
          logId: const Uuid().v4(),
          habitId: habit.habitId,
          date: date,
          completed: true,
        ));
      } else {
        _logs[index] = _logs[index].copyWith(completed: !_logs[index].completed);
      }
    });
  }

  int _currentStreak() {
    if (_logs.isEmpty) return 0;

    final sortedLogs = List<HabitLog>.from(_logs)
      ..sort((a, b) => b.date.compareTo(a.date));

    int streak = 0;
    DateTime? previousDate;

    for (var log in sortedLogs) {
      if (!log.completed) break;
      if (previousDate == null) {
        streak = 1;
      } else {
        final difference = previousDate.difference(log.date).inDays;
        if (difference == 1) {
          streak++;
        } else if (difference > 1) {
          break;
        }
      }
      previousDate = log.date;
    }

    return streak;
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildLogTile(HabitLog log) {
    final formattedDate = DateFormat.yMMMd().format(log.date);

    return ListTile(
      title: Text(formattedDate),
      trailing: Icon(
        log.completed ? Icons.check_circle : Icons.cancel,
        color: log.completed ? Colors.green : Colors.red,
      ),
      onTap: () => _toggleCompletion(log.date),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayLogIndex = _logs.indexWhere((log) => isSameDate(log.date, today));
    final todayCompleted =
        todayLogIndex != -1 ? _logs[todayLogIndex].completed : false;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(habit.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Frequency: '),
                Text(habit.frequency),
              ],
            ),
            Row(
              children: [
                const Text('Shift aligned: '),
                Icon(
                  habit.shiftAligned ? Icons.check : Icons.close,
                  color: habit.shiftAligned ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text('Today\'s completion: '),
                Checkbox(
                  value: todayCompleted,
                  onChanged: (val) {
                    setState(() {
                      if (val != null) {
                        _toggleCompletion(today);
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Current Streak: ${_currentStreak()}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('Completion History:'),
            Expanded(
              child: _logs.isEmpty
                  ? const Center(child: Text('No completion history'))
                  : ListView(
                      children: _logs.map(_buildLogTile).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
