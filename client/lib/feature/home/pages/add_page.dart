import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/add_controller.dart';

class AddPage extends StatelessWidget {
  final String _title = 'Add';

  final AddController _controller = Get.find<AddController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();

  AddPage({super.key});

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: const Icon(Icons.link),
          title: const Text('Add File'),
          onTap: () {
            _controller.navigateToAddFile();
          },
        ),
        ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Upload File'),
          onTap: () {
            _controller.navigateToUploadFile();
          },
        ),
        ListTile(
          leading: const Icon(Icons.playlist_add),
          title: const Text('Add Playlist'),
          onTap: () {
            _controller.navigateToAddPlaylist();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
    );
  }
}
