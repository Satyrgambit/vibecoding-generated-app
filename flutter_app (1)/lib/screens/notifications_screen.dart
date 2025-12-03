import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool habitReminders = true;
  bool streakAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Habit Reminders'),
            value: habitReminders,
            onChanged: (val) {
              setState(() {
                habitReminders = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Streak Alerts'),
            value: streakAlerts,
            onChanged: (val) {
              setState(() {
                streakAlerts = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
