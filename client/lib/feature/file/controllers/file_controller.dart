import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FileController extends GetxController {
  late int _fileId;
  final file = Rxn<File>();
  final tags = Rxn<List<Tag>>();

  final FileRepository _fileRepository = Get.find<FileRepository>();
  final TagRepository _tagRepository = Get.find<TagRepository>();

  @override
  void onInit() {
    super.onInit();
    _fileId = int.parse(Get.arguments['id']);
    loadFile();
    loadTags();
  }

  Future<void> loadFile() async {
    file.value = await _fileRepository.getFile(_fileId);
  }

  Future<void> loadTags() async {
    tags.value = await _tagRepository.getTagsForFile(_fileId);
  }

  Future<void> onSourceTapped() async {
    await Clipboard.setData(ClipboardData(text: file.value!.sourceUrl));
    Get.snackbar('Source URL copied', file.value!.sourceUrl);
  }
}
