import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/file_repository.dart';

class AddFileController extends GetxController {
  final urlFieldController = TextEditingController();

  final FileRepository _repository = Get.find<FileRepository>();

  Future<void> addFile() async {
    try {
      var url = urlFieldController.text;
      var file = await _repository.addFile(url);

      // await _useCase.call();
      // Get.offAndToNamed(Routes.home);
    } on LoginFailure {
      // snackBarController.showError('Login failed, please try again');
    } on UpvibeTimeout {
      // snackBarController.showError('Upvibe server does not respond');
    }
  }
}
