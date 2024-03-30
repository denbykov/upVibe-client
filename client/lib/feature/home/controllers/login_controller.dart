import 'package:get/get.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';

import 'package:client/domain/use_cases/login_use_case.dart';
import 'package:client/core/routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _useCase = Get.find<LoginUseCase>();

  Future<void> login() async {
    try {
      await _useCase.call();
      Get.offAndToNamed(Routes.home);
    } on LoginFailure {
      Get.snackbar('Error', 'Login failed, please try again');
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
    }
  }
}
