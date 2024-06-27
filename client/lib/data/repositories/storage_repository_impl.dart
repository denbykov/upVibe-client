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
  Future<String?> openSelectDirectoryDialog() async {
    return await _datasource.openSelectDirectoryDialog();
  }

  @override
  Future<void> storeInBrightMode(bool isBright) async {
    await _datasource.storeIsBrightMode(isBright);
  }

  @override
  bool? getInBrightMode() {
    return _datasource.getIsBrightMode();
  }

  @override
  Future<void> storeLastSynchronization(DateTime dateTime) async {
    await _datasource.storeLastSynchronization(dateTime);
  }

  @override
  DateTime? getLastSynchronization() {
    return _datasource.getLastSynchronization();
  }

  @override
  Future<String?> openSelectPictureDialog() async {
    return await _datasource.openSelectPictureDialog();
  }
}
