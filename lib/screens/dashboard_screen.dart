import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder habits & streak summary
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _navigateTo(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.today),
                title: const Text('Today\'s Habits'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => _navigateTo(context, '/habits'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.stacked_bar_chart),
                title: const Text('Current Streaks'),
                onTap: () => _navigateTo(context, '/analytics'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Shift Schedule'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => _navigateTo(context, '/shifts'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => _navigateTo(context, '/notifications'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
