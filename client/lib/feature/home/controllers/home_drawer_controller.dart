import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class HomeDrawerController extends GetxController {
  void navigateToSettings() {
    Get.toNamed(Routes.settings);
  }

  void navigateToFiles() {
    Get.toNamed(Routes.files);
  }

  void navigateToPlaylists() {
    Get.toNamed(Routes.playlists);
  }

  void navigateToMappingPriority() {
    Get.toNamed(Routes.mappingPriority);
  }
}
