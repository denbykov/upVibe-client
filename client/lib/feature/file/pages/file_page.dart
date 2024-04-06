import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/domain/entities/file.dart';
import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/file/controllers/file_controller.dart';

class FilePage extends StatelessWidget {
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
              SourceIconWidget(
                color: Get.theme.colorScheme.onSecondaryContainer,
                id: file.source.id,
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

  Widget buildImageTag(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Obx(() {
              bool imageIsReady = (_controller.images.value != null &&
                  _controller.images.value![0].image != null);

              return !imageIsReady
                  ? const CircularProgressIndicator()
                  : Image.memory(
                      _controller.images.value![0].image!,
                      fit: BoxFit.cover,
                    );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildTagsSection(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        children: [
          buildImageTag(context),
          TextTagCarouselSlider(
            label: 'Title',
            items: _controller.tags.value!
                .map((el) => {'text': el.title, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onTitleTagChanged,
          ),
          TextTagCarouselSlider(
            label: 'Atirst',
            items: _controller.tags.value!
                .map((el) => {'text': el.artist, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onTitleTagChanged,
          ),
          TextTagCarouselSlider(
            label: 'Album',
            items: _controller.tags.value!
                .map((el) => {'text': el.album, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onTitleTagChanged,
          )
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.file.value != null && _controller.tags.value != null) {
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

class TextTagCarouselSlider extends StatelessWidget {
  final Function(int index) onPageChanged;
  final List<Map<String, dynamic>> items;
  final String label;

  const TextTagCarouselSlider({
    super.key,
    required this.onPageChanged,
    required this.items,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 0, 0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(label, style: Theme.of(context).textTheme.titleMedium!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 30,
                initialPage: 1,
                onPageChanged: (index, reason) {
                  onPageChanged(index);
                },
                viewportFraction: 1,
                enableInfiniteScroll: false,
              ),
              items: items.map(
                (item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    item['text'] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                                child: SourceIconWidget(
                                  color: Get
                                      .theme.colorScheme.onSecondaryContainer,
                                  id: item['source'],
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
