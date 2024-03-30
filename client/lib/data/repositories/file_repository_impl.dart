import 'package:client/domain/entities/file.dart';
import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class FileRepositoryImpl extends FileRepository {
  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  @override
  Future<File> addFile(String url) async {
    var data = await _upvibeDatasource.addFile(url);
    return data.toEntity();
  }

  @override
  Future<List<File>> getFiles() async {
    final files = await _upvibeDatasource.getFiles();
    return files.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<File> getFile(int id) async {
    final file = await _upvibeDatasource.getFile(id);
    return file.toEntity();
  }
}
