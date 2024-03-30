import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class AddController extends GetxController {
  void navigateToAddFile() {
    Get.offAndToNamed(Routes.addFile);
  }

  void navigateToUploadFile() {
    Get.offAndToNamed(Routes.uploadFille);
  }

  void navigateToAddPlaylist() {
    Get.offAndToNamed(Routes.addPlaylist);
  }
}
