import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

import 'package:client/domain/repositories/storage_repository.dart';

class SettingsController extends GetxController {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();

  Rx<String> version = ''.obs;

  SettingsController() {
    version.value = _storageRepository.getAppVersion();
  }
}
