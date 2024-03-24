import 'package:client/domain/entities/file.dart';
import 'package:client/feature/controllers/assets_controller.dart';
import 'package:client/feature/file/controllers/file_list_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FileListItemWidget extends StatelessWidget {
  final File file;

  final AssetsController _assetsController = Get.find<AssetsController>();
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
                    file.shortTags!.title!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    file.shortTags!.artist!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<SvgPicture>(
                future: _assetsController.getIconBySourceId(file.source.id),
                builder:
                    (BuildContext context, AsyncSnapshot<SvgPicture> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  }
                  return SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: SpinKitPulse(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  );
                },
              ),
            ),
            const Icon(Icons.sync, color: Colors.green, size: 24.0),
          ],
        ),
      ),
      onTap: () => {
        _controller.onTapped(file),
      },
    );
  }
}
