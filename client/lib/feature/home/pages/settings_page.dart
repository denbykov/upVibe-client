import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/settings_controller.dart';
import 'package:client/feature/widgets/app_snack_bar_widget.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _controller = Get.find<SettingsController>();
  final String _title = 'Settings';

  SettingsPage({super.key}) {
    AppSnackBarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
      ),
      body: Center(child: Row()),
    );
  }
}
