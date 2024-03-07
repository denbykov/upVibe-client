import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/data/local/storage_local_datasource.dart';

import 'package:get/get.dart';

class StorageRepositoryImpl extends StorageRepository {
  final StorageLocalDatasource _datasource = Get.find<StorageLocalDatasource>();

  @override
  Future<void> initialize() async {
    await _datasource.initialize();
  }

  @override
  String getAppVersion() {
    return _datasource.getAppVesrion();
  }
}
