import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final String _title = 'Settings';

  final SettingsController _controller = Get.find<SettingsController>();

  SettingsPage({super.key});

  Widget buildInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Card(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
                  child: Icon(Icons.info,
                      color:
                          Theme.of(context).colorScheme.onTertiaryContainer)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: Text(
                  'upVibe client v: ${_controller.version}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildToggleThemeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ElevatedButton(
        onPressed: () {
          _controller.toggleTheme();
        },
        child: const Text('Change theme'),
      ),
    );
  }

  Widget buildDownloadDirectoryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ElevatedButton(
        onPressed: () async {
          await _controller.changeDownloadDirectory();
        },
        child: const Text('Change download directory'),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildInfo(context),
        buildToggleThemeButton(context),
        buildDownloadDirectoryButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
    );
  }
}
