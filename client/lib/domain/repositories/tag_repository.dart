import 'dart:typed_data';

import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/entities/tag_mapping.dart';

abstract class TagRepository {
  Future<List<Tag>> getTagsForFile(String id);

  Future<Uint8List?> getImage(String tagId);

  Future<void> updateMapping(String fileId, TagMapping mapping);
}
