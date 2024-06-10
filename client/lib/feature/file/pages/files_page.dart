import 'package:client/feature/file/widgets/file_list_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/domain/entities/file.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/files_controller.dart';

class FilesPage extends StatelessWidget {
  final FilesController _controller = Get.find<FilesController>();
  final String _title = 'Files';

  FilesPage({super.key});

  Widget buildFileItem(File file) {
    if (file.shortTags != null &&
        file.shortTags!.artist != null &&
        file.shortTags!.artist != null) {}
    return FileListItemWidget(file: file);
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.files.value == null) {
        return const LinearProgressIndicator();
      }

      return ListView.builder(
          itemCount: _controller.files.value?.length ?? 0,
          itemBuilder: (context, index) {
            return buildFileItem(_controller.files.value![index]);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        _controller.stop();
      },
      child: AppScaffoldWidget(
        title: _title,
        body: buildContent(context),
      ),
    );
  }
}
