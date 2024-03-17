import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

// import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/file_repository.dart';

class AddFileController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();
  final SnackBarController snackBarController = Get.find<SnackBarController>();

  final urlFieldController = TextEditingController();

  Future<void> addFile() async {
    try {
      var url = urlFieldController.text;
      var file = await _repository.addFile(url);

      // await _useCase.call();
      // Get.offAndToNamed(Routes.home);
    } on UpvibeTimeout {
      // snackBarController.showError('Upvibe server does not respond');
    } on UpvibeError catch (ex) {
      if (ex.type == UpvibeErrorType.generic) {
        snackBarController.showError(ex.message);
      }
    }
  }
}
