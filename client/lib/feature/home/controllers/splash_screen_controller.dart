import 'package:get/get.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/assets_repository.dart';

class SplashScreenController extends GetxController {
  final AssetsRepository _assetsRepository = Get.find<AssetsRepository>();

  Future<void> initialize() async {
    await _assetsRepository.loadAssets();

    Get.offAndToNamed(Routes.home);
  }
}
