import 'package:client/feature/file/widgets/playlist_list_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/domain/entities/playlist.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/playlists_controller.dart';

class PlaylistsPage extends StatelessWidget {
  final PlaylistsController _controller = Get.find<PlaylistsController>();
  final String _title = 'Playlists';

  PlaylistsPage({super.key});

  Widget buildFileItem(Playlist playlist) {
    return PlaylistListItemWidget(playlist: playlist);
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.playlists.value == null) {
        return const LinearProgressIndicator();
      }

      return ListView.builder(
          itemCount: _controller.playlists.value?.length ?? 0,
          itemBuilder: (context, index) {
            return buildFileItem(_controller.playlists.value![index]);
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
