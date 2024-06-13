import 'dart:async';

import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/entities/extended_file.dart';
import 'package:client/domain/entities/synchronization_report.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:client/exceptions/upvibe_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PictureInfo {
  final String tagId;
  final Uint8List? image;
  final String source;

  PictureInfo(this.tagId, this.image, this.source);
}

class FileController extends GetxController {
  late String _fileId;
  final extendedFile = Rxn<ExtendedFile>();
  final tags = Rxn<List<Tag>>();
  final images = Rxn<List<PictureInfo>>();

  final FileRepository _fileRepository = Get.find<FileRepository>();
  final TagRepository _tagRepository = Get.find<TagRepository>();
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  final titleTagIndex = 0.obs;
  final artistTagIndex = 0.obs;
  final albumTagIndex = 0.obs;
  final yearTagIndex = 0.obs;
  final numberTagIndex = 0.obs;
  final imageTagIndex = 0.obs;

  Timer? _timer;

  StreamSubscription<SynchronizationReport>? _synchronizationSubscription;

  @override
  void onInit() async {
    super.onInit();
    _fileId = Get.arguments['id'];

    _synchronizationSubscription = SynchronizationService().stream.listen(
      (SynchronizationReport data) async {
        try {
          if (data.synchronizedFiles.contains(_fileId)) {
            await loadFile();
            await loadTags();
          }
        } catch (e) {
          debugPrint('Someting went wrong: $e');
        }
      },
    );

    await loadFile();
    await loadTags();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (extendedFile.value == null ||
          extendedFile.value!.file.status != 'C') {
        try {
          await loadFile();
          await loadTags();
        } catch (e) {
          debugPrint('Someting went wrong: $e');
        }
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void stop() {
    _synchronizationSubscription?.cancel();
    _timer?.cancel();
  }

  Future<void> loadFile() async {
    try {
      extendedFile.value = await _fileRepository.getFile(
        _fileId,
        _storageRepository.getDeviceId()!,
      );
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    } on Exception catch (e) {
      debugPrint('Something went wrong: $e');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }

    TagMapping mapping = extendedFile.value!.mapping!;
    titleTagIndex.value = int.parse(mapping.title) - 1;
    artistTagIndex.value = int.parse(mapping.artist) - 1;
    albumTagIndex.value = int.parse(mapping.album) - 1;
    yearTagIndex.value = int.parse(mapping.year) - 1;
    numberTagIndex.value = int.parse(mapping.trackNumber) - 1;
    imageTagIndex.value = int.parse(mapping.picture) - 1;
  }

  Future<void> updateImage(String tagId, int position) async {
    Uint8List? image;

    if (images.value!.elementAt(position).image != null) {
      return;
    }

    try {
      image = await _tagRepository.getImage(tagId);
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }

    final pictureInfo = PictureInfo(
      tagId,
      image,
      '${position + 1}',
    );

    images.value![position] = pictureInfo;
    images.refresh();
  }

  Future<void> loadTags() async {
    try {
      tags.value = await _tagRepository.getTagsForFile(_fileId);
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }

    if (images.value == null || images.value!.length != tags.value!.length) {
      final newImages = <PictureInfo>[];

      for (int i = 0; i < tags.value!.length; i++) {
        final tag = tags.value!.elementAt(i);

        try {
          final image = await _tagRepository.getImage(tag.id);

          final pictureInfo = PictureInfo(
            tag.id,
            image,
            '${i + 1}',
          );

          newImages.add(pictureInfo);
        } on UpvibeError catch (e) {
          debugPrint('${e.toString()}: ${e.errMsg()}');
          Get.snackbar('Error', 'Something went wrong');
          return;
        }
      }

      images.value = newImages;
    } else {
      for (int i = 0; i < tags.value!.length; i++) {
        final tag = tags.value!.elementAt(i);
        await updateImage(tag.id, i);
      }
    }
  }

  Future<void> onSourceTapped() async {
    final file = extendedFile.value!.file;
    await Clipboard.setData(ClipboardData(text: file.sourceUrl));
    Get.snackbar('Source URL copied', file.sourceUrl);
  }

  Future<void> onTitleTagSwapped(int index) async {
    titleTagIndex.value = index;
  }

  Future<void> onArtistTagSwapped(int index) async {
    artistTagIndex.value = index;
  }

  Future<void> onAlbumTagSwapped(int index) async {
    albumTagIndex.value = index;
  }

  Future<void> onYearTagSwapped(int index) async {
    yearTagIndex.value = index;
  }

  Future<void> onNumberTagSwapped(int index) async {
    numberTagIndex.value = index;
  }

  Future<void> onImageTagSwapped(int index) async {
    imageTagIndex.value = index;
  }

  Future<void> onSaveTapped() async {
    final mapping = TagMapping(
      title: '${titleTagIndex.value + 1}',
      artist: '${artistTagIndex.value + 1}',
      album: '${albumTagIndex.value + 1}',
      year: '${yearTagIndex.value + 1}',
      trackNumber: '${numberTagIndex.value + 1}',
      picture: '${imageTagIndex.value + 1}',
    );
    try {
      await _tagRepository.updateMapping(_fileId, mapping);

      await loadFile();
      await loadTags();
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }
  }
}
