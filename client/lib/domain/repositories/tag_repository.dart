import 'package:client/domain/entities/tag.dart';

abstract class TagRepository {
  Future<List<Tag>> getTagsForFile(int id);
}
