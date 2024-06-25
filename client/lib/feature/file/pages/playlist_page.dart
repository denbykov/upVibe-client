import 'package:client/domain/entities/playlist.dart';
import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/playlist_controller.dart';

class PlaylistPage extends StatelessWidget {
  final PlaylistController _controller = Get.find<PlaylistController>();
  final String _title = 'Playlist';

  PlaylistPage({super.key});

  Widget buildHeader(Playlist playlist, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Column(
        children: [
          buildHeadersFirstLine(context, playlist),
          // buildHeadersSecondLine(context, playlist),
        ],
      ),
    );
  }

  Row buildHeadersSecondLine(BuildContext context, Playlist playlist) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        buldSourceHeader(context, playlist),
        Expanded(
          flex: 1,
          child: Icon(Icons.file_open,
              color: Get.theme.colorScheme.secondary, size: 28.0),
        ),
      ],
    );
  }

  Row buildHeadersFirstLine(BuildContext context, Playlist playlist) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 46,
            child: Text(
              playlist.title ?? 'N/A',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () => {},
              child: Icon(Icons.access_time,
                  color: Get.theme.colorScheme.onSecondaryContainer,
                  size: 30.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buldSourceHeader(BuildContext context, Playlist playlist) {
    return Expanded(
      flex: 5,
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => {
            if (_controller.playlist.value!.sourceUrl != null)
              {
                _controller.onSourceTapped(),
              },
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SourceIconWidget(
                  width: 24.0,
                  height: 24.0,
                  color: Get.theme.colorScheme.onSecondaryContainer,
                  id: playlist.source.id,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          playlist.sourceUrl ?? 'N/A',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.playlist.value != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(_controller.playlist.value!, context),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
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
