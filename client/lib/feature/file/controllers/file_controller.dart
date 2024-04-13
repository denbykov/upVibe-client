import 'package:client/domain/entities/extended_file.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:client/domain/repositories/tag_repository.dart';
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

  final titleTagIndex = 0.obs;
  final artistTagIndex = 0.obs;
  final albumTagIndex = 0.obs;
  final yearTagIndex = 0.obs;
  final numberTagIndex = 0.obs;
  final imageTagIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fileId = Get.arguments['id'];
    loadFile();
    loadTags();
  }

  Future<void> loadFile() async {
    extendedFile.value = await _fileRepository.getFile(_fileId);
    TagMapping mapping = extendedFile.value!.mapping!;
    titleTagIndex.value = int.parse(mapping.title) - 1;
    artistTagIndex.value = int.parse(mapping.artist) - 1;
    albumTagIndex.value = int.parse(mapping.album) - 1;
    yearTagIndex.value = int.parse(mapping.year) - 1;
    numberTagIndex.value = int.parse(mapping.trackNumber) - 1;
    imageTagIndex.value = int.parse(mapping.picture) - 1;
  }

  Future<void> loadImage(String tagId, int position) async {
    images.value![position] = PictureInfo(
      tagId,
      await _tagRepository.getImage(tagId),
      '${position + 1}',
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
    await _tagRepository.updateMapping(_fileId, mapping);
  }
}
