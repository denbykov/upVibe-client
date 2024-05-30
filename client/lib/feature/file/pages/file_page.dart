import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/domain/entities/file.dart';
import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

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
          Builder(builder: (context) {
            Color syncColor = file.isSynchronized ? Colors.green : Colors.red;

            return Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
              child: Icon(Icons.sync, color: syncColor, size: 28.0),
            );
          }),
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
            color: Colors.black,
            child: Obx(() {
              if (_controller.images.value == null) {
                return const LinearProgressIndicator();
              }

              var items = _controller.images.value!
                  .map((el) => {'image': el.image, 'source': el.source})
                  .toList();

              return ImageTagCarouselSlider(
                items: items,
                onPageChanged: _controller.onImageTagSwapped,
                initialIndex: _controller.imageTagIndex.value,
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
            onPageChanged: _controller.onTitleTagSwapped,
            initialIndex: _controller.titleTagIndex.value,
          ),
          TextTagCarouselSlider(
            label: 'Atirst',
            items: _controller.tags.value!
                .map((el) => {'text': el.artist, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onArtistTagSwapped,
            initialIndex: _controller.artistTagIndex.value,
          ),
          TextTagCarouselSlider(
            label: 'Album',
            items: _controller.tags.value!
                .map((el) => {'text': el.album, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onAlbumTagSwapped,
            initialIndex: _controller.albumTagIndex.value,
          ),
          TextTagCarouselSlider(
            label: 'Year',
            items: _controller.tags.value!
                .map((el) => {'text': el.year, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onYearTagSwapped,
            initialIndex: _controller.yearTagIndex.value,
          ),
          TextTagCarouselSlider(
            label: 'Number',
            items: _controller.tags.value!
                .map((el) => {'text': el.trackNumber, 'source': el.source})
                .toList(),
            onPageChanged: _controller.onNumberTagSwapped,
            initialIndex: _controller.numberTagIndex.value,
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Obx(() {
      if (_controller.extendedFile.value != null &&
          _controller.tags.value != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(_controller.extendedFile.value!.file, context),
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
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        _controller.stop();
      },
      child: AppScaffoldWidget(
        title: _title,
        body: buildContent(context),
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () => _controller.onSaveTapped(),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onPrimaryContainer),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class TextTagCarouselSlider extends StatelessWidget {
  final Function(int index) onPageChanged;
  final List<Map<String, dynamic>> items;
  final String label;
  final int initialIndex;

  const TextTagCarouselSlider({
    super.key,
    required this.onPageChanged,
    required this.items,
    required this.label,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 0, 0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(label, style: Theme.of(context).textTheme.titleMedium!),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 30,
                initialPage: initialIndex,
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
                      bool isActive = item['text'] != null;
                      return buildItem(context, item, isActive);
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

  Widget buildItem(
      BuildContext context, Map<String, dynamic> item, bool isActive) {
    return Builder(
      builder: (context) {
        if (isActive) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '${item['text']!}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                    color: Get.theme.colorScheme.onSecondaryContainer,
                    id: item['source'],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'N/A',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  child: SourceIconWidget(
                    color: Get.theme.colorScheme.onTertiaryContainer,
                    id: item['source'],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ImageTagCarouselSlider extends StatelessWidget {
  final Function(int index) onPageChanged;
  final List<Map<String, dynamic>> items;
  final int initialIndex;

  const ImageTagCarouselSlider({
    super.key,
    required this.onPageChanged,
    required this.items,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        initialPage: initialIndex,
        onPageChanged: (index, reason) {
          onPageChanged(index);
        },
        viewportFraction: 1,
        enableInfiniteScroll: false,
        height: double.maxFinite,
      ),
      items: items.map(
        (item) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Builder(
                builder: (BuildContext context) {
                  bool isActive = item['image'] != null;
                  return !isActive
                      ? const SizedBox()
                      : Image.memory(
                          item['image']!,
                          fit: BoxFit.cover,
                        );
                },
              ),
              Builder(builder: (context) {
                bool isActive = item['image'] != null;
                Color color = isActive
                    ? Get.theme.colorScheme.secondaryContainer
                    : Get.theme.colorScheme.tertiaryContainer;
                return Positioned(
                  top: 0,
                  right: 0,
                  child: QuarterCircle(
                    color: color,
                  ),
                );
              }),
              Builder(builder: (context) {
                bool isActive = item['image'] != null;
                Color color = isActive
                    ? Get.theme.colorScheme.onSecondaryContainer
                    : Get.theme.colorScheme.onTertiaryContainer;

                return Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: SourceIconWidget(
                      color: color,
                      id: item['source'],
                    ),
                  ),
                );
              })
            ],
          );
        },
      ).toList(),
    );
  }
}

class QuarterCircle extends StatelessWidget {
  final Color color;

  const QuarterCircle({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: QuarterCirclePainter(color: color),
      size: const Size(40, 40),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final Color color;

  QuarterCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width;
    const centerY = 0.0;

    final path = Path()
      ..arcTo(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: size.width),
          pi / 2,
          pi / 2,
          false)
      ..lineTo(centerX, centerY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
