import 'package:get/get.dart';

import 'package:client/domain/use_cases/login_use_case.dart';
import 'package:client/exceptions/login_failure.dart';

class HomeController extends GetxController {
  final LoginUseCase _useCase = Get.find<LoginUseCase>();

  // Rx<int> count = 0.obs;
  // Rx<bool> showSnackBar = false.obs;
  Rx<bool> showSnackBar = false.obs;
  // Rx<String> showSnackBar = false.obs;

  // void increment() {
  //   count.value++;
  // }

  Future<void> login() async {
    try {
      await _useCase.call();
    } on LoginFailure catch (ex) {
      showSnackBar.value = true;
      // ScaffoldState scaffoldState = getState();
      // Get.showSnackbar(snackbar)
    }
  }
}
