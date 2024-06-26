import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/add_playlist_controller.dart';

class AddPlaylistPage extends StatelessWidget {
  final AddPlaylistController _controller = Get.find<AddPlaylistController>();
  final String _title = 'Add playlist';

  AddPlaylistPage({super.key});

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
    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.addPlaylist();
        },
        tooltip: 'Add',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
