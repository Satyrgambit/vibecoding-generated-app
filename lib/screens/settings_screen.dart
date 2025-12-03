import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _exportData() {
    // Placeholder logic for exporting data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('User Profile'),
            onTap: () {
              // Placeholder user profile management
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User Profile not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('App Preferences'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('App Preferences not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Export Data'),
            onTap: () {
              _exportData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting data...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
