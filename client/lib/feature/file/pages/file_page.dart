import 'package:client/domain/entities/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:client/feature/controllers/assets_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/file_controller.dart';

class FilePage extends StatelessWidget {
  final AssetsController _assetsController = Get.find<AssetsController>();
  final FileController _controller = Get.find<FileController>();
  final String _title = 'File';

  FilePage({super.key});

  Widget buildHeader(File file, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          buldSourceHeader(context, file),
          Icon(Icons.file_open,
              color: Get.theme.colorScheme.secondary, size: 28.0),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
            child: const Icon(Icons.sync, color: Colors.green, size: 28.0),
          ),
        ],
      ),
    );
  }

  Widget buldSourceHeader(BuildContext context, File file) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () => {
          _controller.onSourceTapped(),
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FutureBuilder<SvgPicture>(
                future: _assetsController.getIconBySourceId(file.source.id),
                builder:
                    (BuildContext context, AsyncSnapshot<SvgPicture> snapshot) {
                  if (snapshot.hasData) {
                    return SvgPicture(snapshot.data!.bytesLoader,
                        colorFilter: ColorFilter.mode(
                            Get.theme.colorScheme.onSecondaryContainer,
                            BlendMode.srcIn));
                  }
                  return SizedBox(
                    height: 48.0,
                    width: 48.0,
                    child: SpinKitPulse(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  );
                },
              ),
              const SizedBox(width: 8.0),
              Text(file.sourceUrl,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTagsSection(BuildContext context) {
    return Card();
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.file.value != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(_controller.file.value!, context),
            buildTagsSection(context),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: _title,
      body: buildContent(context),
    );
  }
}
