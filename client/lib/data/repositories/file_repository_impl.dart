import 'package:client/domain/entities/extended_file.dart';
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
  Future<List<File>> getFiles(String deviceId) async {
    final files = await _upvibeDatasource.getFiles(deviceId);
    return files.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<ExtendedFile> getFile(String id, String deviceId) async {
    final extendedFile = await _upvibeDatasource.getFile(id, deviceId);
    return extendedFile.toEntity();
  }
}
