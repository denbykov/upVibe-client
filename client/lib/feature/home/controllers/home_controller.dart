import 'package:get/get.dart';

import 'package:client/core/routes.dart';

class HomeController extends GetxController {
  void navigateToAdd() {
    Get.toNamed(Routes.add);
  }
}
