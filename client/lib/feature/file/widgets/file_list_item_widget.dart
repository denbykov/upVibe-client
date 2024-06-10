import 'package:client/domain/entities/file.dart';
import 'package:client/feature/file/controllers/file_list_item_controller.dart';
import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileListItemWidget extends StatelessWidget {
  final File file;

  final FileListItemController _controller = Get.find<FileListItemController>();

  FileListItemWidget({super.key, required this.file});

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
                    file.shortTags?.title ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    file.shortTags?.artist ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: SourceIconWidget(
                color: Get.theme.colorScheme.tertiary,
                id: file.source.id,
              ),
            ),
            Builder(builder: (context) {
              var syncColor = file.isSynchronized ? Colors.green : Colors.red;

              return Icon(Icons.sync, color: syncColor, size: 24.0);
            }),
          ],
        ),
      ),
      onTap: () => {
        _controller.onTapped(file),
      },
    );
  }
}
