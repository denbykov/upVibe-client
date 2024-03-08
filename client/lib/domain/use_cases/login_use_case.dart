import "../repositories/authorization_repository.dart";

import 'package:get/get.dart';

class LoginUseCase {
  final AuthorizationRepository _repository =
      Get.find<AuthorizationRepository>();

  Future<bool> call() async {
    await _repository.login();
    return true;
  }
}
