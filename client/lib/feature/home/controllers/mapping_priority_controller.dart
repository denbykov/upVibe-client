import 'dart:collection';

import 'package:client/domain/entities/tag_mapping_priority.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:get/get.dart';

final class Item extends LinkedListEntry<Item> {
  Item({
    required this.id,
    required this.collection,
  });
  final String id;
  final String collection;
}

class MappingPriorityController extends GetxController {
  final tagMappingPriority = Rxn<TagMappingPriority>();

  final TagRepository _tagRepository = Get.find<TagRepository>();

  final titleItems = Rxn<LinkedList<Item>>();
  final artistItems = Rxn<LinkedList<Item>>();
  final albumItems = Rxn<LinkedList<Item>>();
  final yearItems = Rxn<LinkedList<Item>>();
  final numberItems = Rxn<LinkedList<Item>>();
  final pictureItems = Rxn<LinkedList<Item>>();

  @override
  void onInit() {
    super.onInit();
    loadTagMappingPriority();
  }

  Future<void> loadTagMappingPriority() async {
    final priorities = await _tagRepository.getTagMappingPriority();
    tagMappingPriority.value = priorities;

    parsePriorities(priorities);
  }

  void parsePriorities(TagMappingPriority priorities) {
    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.title.length; i++) {
        list.add(Item(
          id: priorities.title[i],
          collection: 'title',
        ));
      }
      titleItems.value = list;
    }

    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.artist.length; i++) {
        list.add(Item(
          id: priorities.artist[i],
          collection: 'artist',
        ));
      }
      artistItems.value = list;
    }

    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.album.length; i++) {
        list.add(Item(
          id: priorities.album[i],
          collection: 'album',
        ));
      }
      albumItems.value = list;
    }

    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.year.length; i++) {
        list.add(Item(
          id: priorities.year[i],
          collection: 'year',
        ));
      }
      yearItems.value = list;
    }

    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.trackNumber.length; i++) {
        list.add(Item(
          id: priorities.trackNumber[i],
          collection: 'trackNumber',
        ));
      }
      numberItems.value = list;
    }

    {
      final list = LinkedList<Item>();
      for (int i = 0; i < priorities.picture.length; i++) {
        list.add(Item(
          id: priorities.picture[i],
          collection: 'picture',
        ));
      }
      pictureItems.value = list;
    }
  }

  void formatPriorities() {
    final priorities = TagMappingPriority(
      title: titleItems.value!.map((e) => e.id).toList(),
      artist: artistItems.value!.map((e) => e.id).toList(),
      album: albumItems.value!.map((e) => e.id).toList(),
      year: yearItems.value!.map((e) => e.id).toList(),
      trackNumber: numberItems.value!.map((e) => e.id).toList(),
      picture: pictureItems.value!.map((e) => e.id).toList(),
    );

    tagMappingPriority.value = priorities;
  }

  void handleDrop({required Item target, required Item subject}) {
    if (target != subject && target.collection == subject.collection) {
      final list = target.list!;

      final firstItem = list.firstWhere((element) {
        if (element == subject || element == target) {
          return true;
        }
        return false;
      });

      bool subjectIsFirst = firstItem == subject;

      if (subjectIsFirst) {
        list.remove(subject);
        target.insertAfter(subject);
      } else {
        list.remove(subject);
        target.insertBefore(subject);
      }
      formatPriorities();
    }
  }

  Future<void> onSaveTapped() async {
    final priorities = tagMappingPriority.value!;
    await _tagRepository.updateTagMappingPriority(priorities);
  }
}
