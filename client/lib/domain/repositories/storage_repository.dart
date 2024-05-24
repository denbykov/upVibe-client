abstract class StorageRepository {
  Future<void> initialize();

  String getAppVersion();

  String? getDeviceId();
}
