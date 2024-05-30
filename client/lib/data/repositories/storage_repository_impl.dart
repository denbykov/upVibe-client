import 'package:client/data/local/upvibe_local_datasource.dart';
import 'package:client/domain/entities/binary_file.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/data/local/storage_local_datasource.dart';

import 'package:get/get.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageLocalDatasource _datasource = Get.find<StorageLocalDatasource>();

  final UpvibeLocalDatasource _upvibeLocalDatasource =
      Get.find<UpvibeLocalDatasource>();

  bool isInitialized = false;

  @override
  Future<void> ensureInitialized() async {
    if (isInitialized) return;

    await _datasource.initialize();
    await _upvibeLocalDatasource.initialize();

    await storeDefaultFilePath('/storage/emulated/0/Download/');

    isInitialized = true;
  }

  @override
  String getAppVersion() {
    return _datasource.getAppVesrion();
  }

  @override
  String? getDeviceId() {
    return _datasource.getUuid();
  }

  @override
  Future<void> saveFile(BinaryFile file, String path) async {
    await _datasource.saveFile(file, path);
  }

  @override
  String? getDefaultFilePath() {
    return _datasource.getDefaultFilePath();
  }

  @override
  Future<void> storeDefaultFilePath(String? path) async {
    await _datasource.storeDefaultFilePath(path);
  }

  @override
  Future<void> setAppStatus(bool isActive) async {
    await _datasource.setAppStatus(isActive);
  }

  @override
  bool? isAppActive() {
    return _datasource.getAppStatus();
  }
}
