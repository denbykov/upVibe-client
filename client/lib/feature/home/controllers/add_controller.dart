import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class AddController extends GetxController {
  void navigateToAddFile() {
    Get.toNamed(Routes.addFile);
  }

  void navigateToUploadFile() {
    Get.toNamed(Routes.uploadFille);
  }

  void navigateToAddPlaylist() {
    Get.toNamed(Routes.addPlaylist);
  }
}
