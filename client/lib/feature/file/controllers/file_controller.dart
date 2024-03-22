import 'package:client/domain/entities/file.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FileController extends GetxController {
  late int _fileId;
  // Rx<File?> file = null.obs;
  final file = Rxn<File>();

  final FileRepository _repository = Get.find<FileRepository>();

  @override
  void onInit() {
    super.onInit();
    _fileId = int.parse(Get.arguments['id']);
    loadFile();
  }

  Future<void> loadFile() async {
    file.value = await _repository.getFile(_fileId);
  }

  Future<void> onSourceTapped() async {
    await Clipboard.setData(ClipboardData(text: file.value!.sourceUrl));
    Get.snackbar('Source URL copied', file.value!.sourceUrl);
  }
}
