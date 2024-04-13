import 'dart:typed_data';

import 'package:client/data/dto/tag_mapping_dto.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';
import 'package:client/domain/repositories/tag_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class TagRepositoryImpl extends TagRepository {
  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();
  @override
  Future<List<Tag>> getTagsForFile(String id) async {
    final tags = await _upvibeDatasource.getTagsForFile(id);
    return tags.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Uint8List?> getImage(String tagId) async {
    return await _upvibeDatasource.getTagImage(tagId);
  }

  @override
  Future<void> updateMapping(String fileId, TagMapping mapping) async {
    await _upvibeDatasource.updateMapping(
        fileId, TagMappingDTO.fromEntity(mapping));
  }
}
