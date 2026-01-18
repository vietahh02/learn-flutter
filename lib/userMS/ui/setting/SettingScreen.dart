import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[700],
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Card(
              color: Colors.grey[600],
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Profile Settings',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  // TODO: Navigate to profile settings
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.grey[600],
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.white),
                title: Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.grey[600],
              child: ListTile(
                leading: Icon(Icons.language, color: Colors.white),
                title: Text(
                  'Language',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  // TODO: Navigate to language settings
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.grey[600],
              child: ListTile(
                leading: Icon(Icons.dark_mode, color: Colors.white),
                title: Text(
                  'Theme',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  // TODO: Navigate to theme settings
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
