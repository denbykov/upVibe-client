import 'package:client/domain/entities/tag.dart';
import 'package:client/domain/repositories/tag_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class TagRepositoryImpl extends TagRepository {
  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();
  @override
  Future<List<Tag>> getTagsForFile(int id) async {
    final tags = await _upvibeDatasource.getTagsForFile(id);
    return tags.map((dto) => dto.toEntity()).toList();
  }
}
