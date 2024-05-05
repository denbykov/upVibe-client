import 'dart:collection';

import 'package:client/feature/widgets/source_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';
import 'package:client/feature/home/controllers/mapping_priority_controller.dart';

class PriorityListItem extends StatelessWidget {
  const PriorityListItem({
    super.key,
    required this.item,
    required this.isHovered,
  });

  final Item item;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isHovered
        ? Get.theme.colorScheme.secondaryContainer.withOpacity(0.5)
        : Get.theme.colorScheme.secondaryContainer;

    final iconColor = isHovered
        ? Get.theme.colorScheme.onSecondaryContainer.withOpacity(0.5)
        : Get.theme.colorScheme.onPrimaryContainer;

    return Material(
      elevation: 2,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: SourceIconWidget(
                  color: iconColor,
                  id: item.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Get.theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: SourceIconWidget(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  id: item.id,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MappingPriorityPage extends StatelessWidget {
  final String _title = 'Mapping priority';

  final MappingPriorityController _controller =
      Get.find<MappingPriorityController>();

  MappingPriorityPage({super.key});

  Widget buildRowItem(
    Item item,
  ) {
    return DragTarget<Item>(
      builder: (context, candidateItems, rejectedItems) {
        return Draggable<Item>(
          data: item,
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedback: DraggingListItem(
            item: item,
          ),
          child: PriorityListItem(
            item: item,
            isHovered: candidateItems.isEmpty ? false : true,
          ),
        );
      },
      onAcceptWithDetails: (details) {
        _controller.handleDrop(target: item, subject: details.data);
      },
    );
  }

  Widget buildRow(
      {required String title, required Rxn<LinkedList<Item>> data}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: SizedBox(
          height: 40.0,
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: Text(title, style: Get.textTheme.titleMedium!),
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(1),
                  itemCount: data.value!.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 12,
                    );
                  },
                  itemBuilder: (context, index) {
                    final item = data.value!.elementAt(index);
                    return buildRowItem(
                      item,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          if (_controller.tagMappingPriority.value == null) {
            return const LinearProgressIndicator();
          }

          return Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              children: [
                buildRow(title: 'Title', data: _controller.titleItems),
                buildRow(title: 'Artist', data: _controller.artistItems),
                buildRow(title: 'Album', data: _controller.albumItems),
                buildRow(title: 'Year', data: _controller.yearItems),
                buildRow(title: 'Number', data: _controller.numberItems),
                buildRow(title: 'Picture', data: _controller.pictureItems),
              ],
            ),
          );
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
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
    );
  }
}
