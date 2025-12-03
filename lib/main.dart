import 'package:flutter/material.dart';
import 'package:shift_habit/screens/dashboard_screen.dart';
import 'package:shift_habit/screens/login_screen.dart';
import 'package:shift_habit/screens/settings_screen.dart';
import 'package:shift_habit/screens/habit_list_screen.dart';
import 'package:shift_habit/screens/shift_schedule_screen.dart';
import 'package:shift_habit/screens/notifications_screen.dart';
import 'package:shift_habit/screens/progress_analytics_screen.dart';
import 'package:shift_habit/screens/habit_detail_screen.dart';

void main() {
  runApp(const ShiftHabitApp());
}

class ShiftHabitApp extends StatelessWidget {
  const ShiftHabitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShiftHabit',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/habits': (context) => const HabitListScreen(),
        '/habit_detail': (context) => const HabitDetailScreen(),
        '/shifts': (context) => const ShiftScheduleScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/analytics': (context) => const ProgressAnalyticsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
