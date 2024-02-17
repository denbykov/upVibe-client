import 'package:flutter/material.dart';

// import '../pages/files.dart';
// import '../pages/settings.dart';

class HomeDrawerWidget extends Drawer {
  const HomeDrawerWidget({super.key});
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FilesPage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SettingsPage()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
