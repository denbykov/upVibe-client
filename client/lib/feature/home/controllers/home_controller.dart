import 'package:client/domain/repositories/storage_repository.dart';
import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class HomeController extends GetxController {
  final _storageRepository = Get.find<StorageRepository>();
  final defaultFilePathIsSet = false.obs;

  void initialize() {
    if (_storageRepository.getDefaultFilePath() == null) {
      defaultFilePathIsSet.value = false;
    } else {
      defaultFilePathIsSet.value = true;
    }
  }

  Future<void> changeDownloadDirectory() async {
    final dir = await _storageRepository.openSelectDirectoryDialog();
    if (dir == null) return;
    await _storageRepository.storeDefaultFilePath(dir);
    defaultFilePathIsSet.value = true;
  }

  void navigateToAdd() {
    Get.toNamed(Routes.add);
  }
}
