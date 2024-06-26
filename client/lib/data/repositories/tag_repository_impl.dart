import 'dart:typed_data';

import 'package:client/data/dto/short_tags_dto.dart';
import 'package:client/data/dto/tag_mapping_dto.dart';
import 'package:client/data/dto/tag_mapping_priority_dto.dart';
import 'package:client/domain/entities/short_tags.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';
import 'package:client/domain/entities/tag_mapping_priority.dart';
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

  @override
  Future<TagMappingPriority> getTagMappingPriority() async {
    final dto = await _upvibeDatasource.getTagMappingPriority();
    return dto.toEntity();
  }

  @override
  Future<void> updateTagMappingPriority(TagMappingPriority priority) async {
    await _upvibeDatasource
        .updateTagMappingPriority(TagMappingPriorityDTO.fromEntity(priority));
  }

  @override
  Future<void> updateCustomTags(String fileId, ShortTags tags) async {
    await _upvibeDatasource.updateCustomTags(
        fileId, ShortTagsDTO.fromEntity(tags));
  }
}
