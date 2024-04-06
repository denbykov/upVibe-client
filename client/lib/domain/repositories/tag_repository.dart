import 'dart:typed_data';

import 'package:client/domain/entities/tag.dart';

abstract class TagRepository {
  Future<List<Tag>> getTagsForFile(int id);

  Future<Uint8List?> getImage(int tagId);
}
