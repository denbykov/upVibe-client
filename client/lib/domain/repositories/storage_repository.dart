import 'package:client/domain/entities/binary_file.dart';

abstract class StorageRepository {
  Future<void> ensureInitialized();

  String getAppVersion();

  String? getDeviceId();

  Future<void> saveFile(BinaryFile file, String path);

  String? getDefaultFilePath();

  Future<void> storeDefaultFilePath(String? path);

  Future<String?> openSelectDirectoryDialog();

  Future<void> storeInBrightMode(bool isBright);

  bool? getInBrightMode();

  Future<void> storeLastSynchronization(DateTime dateTime);

  DateTime? getLastSynchronization();

  Future<String?> openSelectPictureDialog();
}
