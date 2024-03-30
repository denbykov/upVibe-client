import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class HomeDrawerController extends GetxController {
  void navigateToSettings() {
    Get.toNamed(Routes.settings);
  }

  void navigateToFiles() {
    Get.toNamed(Routes.files);
  }
}
