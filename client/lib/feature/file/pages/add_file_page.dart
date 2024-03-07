import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:client/feature/home/controllers/settings_controller.dart';
import 'package:client/feature/widgets/app_snack_bar_widget.dart';
import 'package:client/feature/widgets/app_scaffold.dart';

class AddFilePage extends StatelessWidget {
  // final SettingsController _controller = Get.find<SettingsController>();
  final String _title = 'Add File';

  AddFilePage({super.key}) {
    AppSnackBarWidget();
  }

  Widget buildEnterUrlField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Paste url'),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEnterUrlField(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: _title,
      body: buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.navigateToAdd();
        },
        tooltip: 'Add',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
