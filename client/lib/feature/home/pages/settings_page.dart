import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/settings_controller.dart';
import 'package:client/feature/widgets/app_snack_bar_widget.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _controller = Get.find<SettingsController>();
  final String _title = 'Settings';

  SettingsPage({super.key}) {
    AppSnackBarWidget();
  }

  Widget buildInfo(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
                child: Icon(Icons.info,
                    color: Theme.of(context).colorScheme.onTertiaryContainer)),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: Text('upVibe client v: ${_controller.version}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onTertiaryContainer)),
            ),
          ],
        ));
  }

  Container buildContent(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildInfo(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: buildContent(context),
    );
  }
}
