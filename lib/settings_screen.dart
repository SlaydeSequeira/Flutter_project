import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          _buildSettingsOption(Icons.person, 'Profile', () {
            // Navigate to Profile Settings
          }),
          _buildSettingsOption(Icons.notifications, 'Notifications', () {
            // Navigate to Notifications Settings
          }),
          _buildSettingsOption(Icons.privacy_tip, 'Privacy', () {
            // Navigate to Privacy Settings
          }),
          _buildSettingsOption(Icons.help, 'Help & Support', () {
            // Navigate to Help & Support
          }),
          _buildSettingsOption(Icons.logout, 'Logout', () {
            // Handle logout action
          }),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: onTap,
    );
  }
}
