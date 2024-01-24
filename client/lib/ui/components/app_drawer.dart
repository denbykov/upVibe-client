import 'package:flutter/material.dart';

import '../screens/files.dart';
import '../screens/settings.dart';

class AppDrawer extends Drawer {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: const Text('UpVibe'),
          ),
          ListTile(
            title: const Text('Files'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilesScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
