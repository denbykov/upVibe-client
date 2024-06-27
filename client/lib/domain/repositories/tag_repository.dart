import 'dart:typed_data';

import 'package:client/domain/entities/short_tags.dart';
import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';
import 'package:client/domain/entities/tag_mapping_priority.dart';

abstract class TagRepository {
  Future<List<Tag>> getTagsForFile(String id);

  Future<Uint8List?> getImage(String tagId);

  Future<void> updateMapping(String fileId, TagMapping mapping);

  Future<TagMappingPriority> getTagMappingPriority();

  Future<void> updateTagMappingPriority(TagMappingPriority priority);

  Future<void> updateCustomTags(String fileId, ShortTags tags);

  Future<void> uploadPicture(String path, String fileId);
}
