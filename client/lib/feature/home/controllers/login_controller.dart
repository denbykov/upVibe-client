import 'package:client/domain/repositories/storage_repository.dart';
import 'package:get/get.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';

import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/core/routes.dart';

class LoginController extends GetxController {
  final loginFailed = false.obs;

  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  final AuthorizationRepository _repository =
      Get.find<AuthorizationRepository>();

  Future<void> ensureDeviceRegistration() async {
    await _repository.ensureDeviceRegistration();
  }

  Future<void> login() async {
    try {
      await _storageRepository.ensureInitialized();

      await _repository.login();
      await ensureDeviceRegistration();
      Get.offAndToNamed(Routes.splashScreen);
    } on LoginFailure {
      loginFailed.value = true;
      Get.snackbar('Error', 'Login failed, please try again');
    } on UpvibeTimeout {
      loginFailed.value = true;
      Get.snackbar('Error', 'Upvibe server does not respond');
    } catch (e) {
      loginFailed.value = true;
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
