import 'package:get/get.dart';

class SnackBarController extends GetxController {
  final int duration = 3;

  Function(String, int)? _onError;

  void showError(String message) {
    _onError!(message, duration);
  }

  registerOnErrorCallback(Function(String, int) callback) {
    _onError = callback;
  }
}
