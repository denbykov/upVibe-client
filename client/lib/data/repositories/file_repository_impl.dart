import 'package:client/data/dto/local_file_dto.dart';
import 'package:client/data/local/upvibe_local_datasource.dart';
import 'package:client/domain/entities/binary_file.dart';
import 'package:client/domain/entities/extended_file.dart';
import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/local_file.dart';
import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class FileRepositoryImpl extends FileRepository {
  final UpvibeRemoteDatasource _upvibeRemoteDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final UpvibeLocalDatasource _upvibeLocalDatasource =
      Get.find<UpvibeLocalDatasource>();

  @override
  Future<File> addFile(String url) async {
    var data = await _upvibeRemoteDatasource.addFile(url);
    return data.toEntity();
  }

  @override
  Future<List<File>> getFiles(String deviceId,
      {List<String>? statuses, bool? isSynronized}) async {
    final files = await _upvibeRemoteDatasource.getFiles(deviceId,
        statuses: statuses, isSynronized: isSynronized);
    return files.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<ExtendedFile> getFile(String id, String deviceId) async {
    final extendedFile = await _upvibeRemoteDatasource.getFile(id, deviceId);
    return extendedFile.toEntity();
  }

  @override
  Future<BinaryFile> downloadFile(String id) async {
    final binaryFile = await _upvibeRemoteDatasource.downloadFile(id);
    return binaryFile.toEntity();
  }

  @override
  Future<void> confirmFile(String id, String deviceId) async {
    await _upvibeRemoteDatasource.confirmFile(id, deviceId);
  }

  @override
  Future<void> upsertFile(LocalFile file) async {
    await _upvibeLocalDatasource.upsertFile(LocalFileDTO.fromEntity(file));
  }
}
