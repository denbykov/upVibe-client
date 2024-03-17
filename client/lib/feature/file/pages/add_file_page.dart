import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/add_file_controller.dart';

class AddFilePage extends StatelessWidget {
  final AddFileController _controller = Get.find<AddFileController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();
  final String _title = 'Add File';

  AddFilePage({super.key});

  Widget buildEnterUrlField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Paste url',
              ),
              controller: _controller.urlFieldController,
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
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.addFile();
        },
        tooltip: 'Add',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
