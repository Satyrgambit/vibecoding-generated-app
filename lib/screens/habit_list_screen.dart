import 'package:flutter/material.dart';
import 'package:shift_habit/models/habit.dart';
import 'package:uuid/uuid.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({Key? key}) : super(key: key);

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  final List<Habit> _habits = [];

  void _addHabit() {
    _showHabitForm();
  }

  void _editHabit(Habit habit) {
    _showHabitForm(habit: habit);
  }

  void _deleteHabit(Habit habit) {
    setState(() {
      _habits.removeWhere((h) => h.habitId == habit.habitId);
    });
  }

  void _showHabitForm({Habit? habit}) {
    final titleController = TextEditingController(text: habit?.title ?? '');
    final descriptionController = TextEditingController(text: habit?.description ?? '');
    final frequencyController = TextEditingController(text: habit?.frequency ?? 'Daily');
    bool shiftAligned = habit?.shiftAligned ?? false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(habit == null ? 'Add Habit' : 'Edit Habit'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: frequencyController,
                  decoration: const InputDecoration(labelText: 'Frequency (e.g., Daily)'),
                ),
                Row(
                  children: [
                    const Text('Shift Aligned'),
                    Checkbox(
                      value: shiftAligned,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            shiftAligned = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () { Navigator.of(context).pop(); },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final enteredTitle = titleController.text.trim();
                final enteredDescription = descriptionController.text.trim();
                final enteredFrequency = frequencyController.text.trim();

                if (enteredTitle.isEmpty || enteredDescription.isEmpty || enteredFrequency.isEmpty) {
                  return;
                }

                setState(() {
                  if (habit == null) {
                    _habits.add(Habit(
                      habitId: const Uuid().v4(),
                      userId: 'demo_user',
                      title: enteredTitle,
                      description: enteredDescription,
                      frequency: enteredFrequency,
                      shiftAligned: shiftAligned,
                    ));
                  } else {
                    final index = _habits.indexWhere((h) => h.habitId == habit.habitId);
                    if (index != -1) {
                      _habits[index] = habit.copyWith(
                        title: enteredTitle,
                        description: enteredDescription,
                        frequency: enteredFrequency,
                        shiftAligned: shiftAligned,
                      );
                    }
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _openHabitDetail(Habit habit) {
    Navigator.pushNamed(context, '/habit_detail', arguments: habit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
      ),
      body: _habits.isEmpty
          ? const Center(child: Text('No habits. Add some!'))
          : ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                final habit = _habits[index];
                return ListTile(
                  title: Text(habit.title),
                  subtitle: Text(habit.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editHabit(habit),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteHabit(habit),
                      ),
                    ],
                  ),
                  onTap: () => _openHabitDetail(habit),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
