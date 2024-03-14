import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';
import 'package:client/data/local/storage_local_datasource.dart';

import 'package:get/get.dart';

class FileRepositoryImpl extends FileRepository {
  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final StorageLocalDatasource _storageDatasource =
      Get.find<StorageLocalDatasource>();

  @override
  Future<void> addFile(String url) async {
    var data = await _upvibeDatasource.addFile(url);
    // return
  }
}
