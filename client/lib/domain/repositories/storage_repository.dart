import 'package:client/domain/entities/binary_file.dart';

abstract class StorageRepository {
  Future<void> ensureInitialized();

  String getAppVersion();

  String? getDeviceId();

  Future<void> saveFile(BinaryFile file, String path);

  String? getDefaultFilePath();

  Future<void> storeDefaultFilePath(String? path);

  Future<void> setAppStatus(bool isActive);

  bool? isAppActive();
}
