import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/home_drawer_controller.dart';

class HomeDrawerWidget extends Drawer {
  final HomeDrawerController _controller = Get.find<HomeDrawerController>();

  HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const ContinuousRectangleBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              'UpVibe',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              _controller.navigateToSettings();
            },
          ),
          ListTile(
            leading: const Icon(Icons.queue_music),
            title: const Text('Files'),
            onTap: () {
              _controller.navigateToFiles();
            },
          )
        ],
      ),
    );
  }
}
