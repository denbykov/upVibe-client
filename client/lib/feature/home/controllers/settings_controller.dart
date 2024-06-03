import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/domain/repositories/storage_repository.dart';

class SettingsController extends GetxController {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  Rx<String> version = ''.obs;

  SettingsController() {
    version.value = _storageRepository.getAppVersion();
  }

  void toggleTheme() {
    final newTheme = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(newTheme);

    bool isBright = (newTheme == ThemeMode.light) ? true : false;

    _storageRepository.storeInBrightMode(isBright);
  }

  Future<void> changeDownloadDirectory() async {
    final dir = await _storageRepository.openSelectDirectoryDialog();
    if (dir == null) return;
    await _storageRepository.storeDefaultFilePath(dir);
  }
}
