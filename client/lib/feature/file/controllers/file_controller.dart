import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PictureInfo {
  final int tagId;
  final Uint8List? image;
  final int source;

  PictureInfo(this.tagId, this.image, this.source);
}

class FileController extends GetxController {
  late int _fileId;
  final file = Rxn<File>();
  final tags = Rxn<List<Tag>>();
  final images = Rxn<List<PictureInfo>>();

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

  Future<void> loadImage(int tagId, int position) async {
    images.value![position] = PictureInfo(
      tagId,
      await _tagRepository.getImage(tagId),
      0,
    );
    images.refresh();
  }

  Future<void> loadTags() async {
    tags.value = await _tagRepository.getTagsForFile(_fileId);
    images.value = [];
    for (final tag in tags.value!) {
      images.value!.add(PictureInfo(tag.id, null, tag.source));
      loadImage(tag.id, images.value!.length - 1);
    }
  }

  Future<void> onSourceTapped() async {
    await Clipboard.setData(ClipboardData(text: file.value!.sourceUrl));
    Get.snackbar('Source URL copied', file.value!.sourceUrl);
  }

  Future<void> onTitleTagChanged(int index) async {}
}
