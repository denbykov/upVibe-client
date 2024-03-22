import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/domain/entities/file.dart';

class FilesController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();
  final SnackBarController snackBarController = Get.find<SnackBarController>();

  Future<List<File>> getFiles() async {
    try {
      return await _repository.getFiles();
    } on UpvibeTimeout {
      snackBarController.showError('Upvibe server does not respond');
      return [];
    } on UpvibeError catch (ex) {
      if (ex.type == UpvibeErrorType.generic) {
        snackBarController.showError(ex.message);
      }
      return [];
    }
  }
}
