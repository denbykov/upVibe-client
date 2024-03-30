import 'package:get/get.dart';

import 'package:client/domain/repositories/storage_repository.dart';

class SettingsController extends GetxController {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  Rx<String> version = ''.obs;

  SettingsController() {
    version.value = _storageRepository.getAppVersion();
  }
}
