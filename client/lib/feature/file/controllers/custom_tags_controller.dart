import 'dart:async';

import 'package:client/domain/entities/custom_tags_update_result.dart';
import 'package:client/domain/entities/short_tags.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/exceptions/upvibe_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTagsController extends GetxController {
  late String _fileId;

  final isInitalized = false.obs;

  late TextEditingController titleFieldController;
  late TextEditingController artistFieldController;
  late TextEditingController albumFieldController;
  late TextEditingController yearFieldController;
  late TextEditingController numberFieldController;

  String? picturePath;

  final TagRepository _tagRepository = Get.find<TagRepository>();
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  @override
  void onInit() async {
    super.onInit();

    final arguments = Get.arguments;

    _fileId = arguments['fileId'];
    titleFieldController =
        TextEditingController(text: arguments['title'] ?? '');
    artistFieldController =
        TextEditingController(text: arguments['artist'] ?? '');
    albumFieldController =
        TextEditingController(text: arguments['album'] ?? '');
    yearFieldController =
        TextEditingController(text: arguments['year']?.toString() ?? '');
    numberFieldController =
        TextEditingController(text: arguments['number']?.toString() ?? '');

    isInitalized.value = true;
  }

  Future<void> onSaveTapped() async {
    final tags = ShortTags(
      title: titleFieldController.text,
      artist: artistFieldController.text,
      album: albumFieldController.text,
      year: int.tryParse(yearFieldController.text),
      trackNumber: int.tryParse(numberFieldController.text),
    );
    try {
      await _tagRepository.updateCustomTags(_fileId, tags);

      final pictureUpdated = picturePath != null;
      if (pictureUpdated) {
        await _tagRepository.uploadPicture(picturePath!, _fileId);
      }

      final result = CustomTagsUpdateResult(
        textTagsChanged: true,
        pictureTagChanged: pictureUpdated,
      );
      Get.back(result: result);
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }
  }

  Future<void> onSetPicturePressed() async {
    final result = await _storageRepository.openSelectPictureDialog();
    if (result == null) return;
    picturePath = result;
  }
}
