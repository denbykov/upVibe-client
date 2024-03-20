import 'package:client/domain/entities/source.dart';
import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/domain/entities/file.dart';

class FilesController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();
  final SnackBarController snackBarController = Get.find<SnackBarController>();

  // Future<void> addFile() async {
  //   try {
  //     // var file = await _repository.addFile(url);

  //     // Get.offAndToNamed(Routes.file);
  //   } on UpvibeTimeout {
  //     snackBarController.showError('Upvibe server does not respond');
  //   } on UpvibeError catch (ex) {
  //     if (ex.type == UpvibeErrorType.generic) {
  //       snackBarController.showError(ex.message);
  //     }
  //   }
  // }

  Future<List<File>> getFiles() async {
    const file = File(
      id: 1,
      source: Source(id: 1, source: 'YouTube'),
      status: 'I',
      sourceUrl: 'https://www.youtube.com/watch?v=6n3pFFPSlW4',
      shortTags: ShortTags(
          title: 'Hey Jude',
          artist: 'The Beatles',
          album: 'The Beatles 1967-1970',
          year: 1970,
          trackNumber: 1),
    );

    return [
      file,
      file,
      file,
      file,
      file,
      file,
      file,
      file,
      file,
      file,
      file,
      file,
    ];
  }
}
