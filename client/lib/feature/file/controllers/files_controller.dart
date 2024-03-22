import 'package:get/get.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/domain/entities/file.dart';

class FilesController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();

  Future<List<File>> getFiles() async {
    try {
      return await _repository.getFiles();
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
      return [];
    } on UpvibeError catch (ex) {
      if (ex.type == UpvibeErrorType.generic) {
        Get.snackbar('Error', ex.message);
      }
      return [];
    }
  }
}
