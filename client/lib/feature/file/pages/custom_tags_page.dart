import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/custom_tags_controller.dart';

class CustomTagsPage extends StatelessWidget {
  final CustomTagsController _controller = Get.find<CustomTagsController>();
  final String _title = 'Custom tags';

  CustomTagsPage({super.key});

  Widget buildContent(BuildContext context) {
    return Obx(
      () {
        if (_controller.isInitalized.isFalse) {
          return const LinearProgressIndicator();
        }

        return ListView(
          children: [
            buildEditField(context, 'Title', _controller.titleFieldController),
            buildEditField(
                context, 'Artist', _controller.artistFieldController),
            buildEditField(context, 'Album', _controller.albumFieldController),
            buildEditField(context, 'Year', _controller.yearFieldController),
            buildEditField(
                context, 'Number', _controller.numberFieldController),
          ],
        );
      },
    );
  }

  Widget buildEditField(
      BuildContext context, String label, TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: label,
              ),
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: AppScaffoldWidget(
        title: _title,
        body: buildContent(context),
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () => _controller.onSaveTapped(),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onPrimaryContainer),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
