import 'package:get/get.dart';

class SnackBarController extends GetxController {
  final Rx<bool> display = false.obs;
  String title = '';
  String message = '';
  final int duration = 3;

  void showError(String message) {
    title = "Error";
    this.message = message;

    display.value = true;

    Future.delayed(Duration(seconds: duration), () {
      title = '';
      this.message = '';

      display.value = false;
    });
  }
}
