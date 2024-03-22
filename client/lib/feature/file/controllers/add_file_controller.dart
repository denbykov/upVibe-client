import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/file_repository.dart';

class AddFileController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();

  final urlFieldController = TextEditingController();

  Future<void> addFile() async {
    try {
      var url = urlFieldController.text;
      var file = await _repository.addFile(url);

      Get.offAndToNamed(Routes.home);
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
    } on UpvibeError catch (ex) {
      if (ex.type == UpvibeErrorType.generic) {
        Get.snackbar('Error', ex.message);
      }
    }
  }
}
