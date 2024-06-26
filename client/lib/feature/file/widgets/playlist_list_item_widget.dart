import 'package:client/domain/entities/playlist.dart';
import 'package:client/feature/file/controllers/playlist_list_item_controller.dart';
import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistListItemWidget extends StatelessWidget {
  final Playlist playlist;

  final PlaylistListItemController _controller =
      Get.find<PlaylistListItemController>();

  PlaylistListItemWidget({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal:
                BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: SourceIconWidget(
                width: 24.0,
                height: 24.0,
                color: Get.theme.colorScheme.tertiary,
                id: playlist.source.id,
              ),
            ),
          ],
        ),
      ),
      onTap: () => {
        _controller.onTapped(playlist),
      },
    );
  }
}
