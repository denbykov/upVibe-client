import 'package:get/get.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/storage_repository.dart';

class SplashScreenController extends GetxController {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  Future<void> initialize() async {
    await _storageRepository.initialize();
    Get.offAndToNamed(Routes.login);
  }
}
