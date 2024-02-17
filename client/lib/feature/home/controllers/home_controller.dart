import 'package:get/get.dart';

class HomeController extends GetxController {
  // late

  Rx<int> count = 0.obs;

  void increment() {
    count.value++;
  }
}
