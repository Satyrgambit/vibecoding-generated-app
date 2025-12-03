import 'package:flutter/material.dart';
import 'package:shift_habit/models/shift_schedule.dart';
import 'package:uuid/uuid.dart';

class ShiftScheduleScreen extends StatefulWidget {
  const ShiftScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ShiftScheduleScreen> createState() => _ShiftScheduleScreenState();
}

class _ShiftScheduleScreenState extends State<ShiftScheduleScreen> {
  final List<ShiftSchedule> _shifts = [];

  void _addShift() {
    DateTime? startTime;
    DateTime? endTime;
    final shiftTypeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Add Shift'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(startTime == null
                        ? 'Select Start Time'
                        : startTime.toString()),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                        );
                        if (time != null) {
                          setStateDialog(() {
                            startTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                          });
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: Text(endTime == null
                        ? 'Select End Time'
                        : endTime.toString()),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                        );
                        if (time != null) {
                          setStateDialog(() {
                            endTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                          });
                        }
                      }
                    },
                  ),
                  TextField(
                    controller: shiftTypeController,
                    decoration: const InputDecoration(labelText: 'Shift Type'),
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
                  if (startTime != null && endTime != null && shiftTypeController.text.isNotEmpty) {
                    setState(() {
                      _shifts.add(
                        ShiftSchedule(
                          shiftId: const Uuid().v4(),
                          userId: 'demo_user',
                          startTime: startTime!,
                          endTime: endTime!,
                          shiftType: shiftTypeController.text.trim(),
                        ),
                      );
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  void _deleteShift(ShiftSchedule shift) {
    setState(() {
      _shifts.removeWhere((s) => s.shiftId == shift.shiftId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Schedule'),
      ),
      body: _shifts.isEmpty
          ? const Center(child: Text('No shifts. Add some!'))
          : ListView.builder(
              itemCount: _shifts.length,
              itemBuilder: (context, index) {
                final shift = _shifts[index];
                return ListTile(
                  title: Text('${shift.shiftType}'),
                  subtitle: Text(
                      '${shift.startTime} - ${shift.endTime}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteShift(shift),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addShift,
        child: const Icon(Icons.add),
      ),
    );
  }
}
