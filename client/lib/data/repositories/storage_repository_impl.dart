import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/data/local/storage_local_datasource.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageLocalDatasource _datasource = Get.find<StorageLocalDatasource>();

  late PackageInfo _packageInfo;

  @override
  Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    await _datasource.initialize();
  }

  @override
  String getAppVersion() {
    return _packageInfo.version;
  }
}
