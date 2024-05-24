import 'package:client/domain/repositories/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/domain/entities/file.dart';

class FilesController extends GetxController {
  final FileRepository _repository = Get.find<FileRepository>();
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  Future<List<File>> getFiles() async {
    try {
      return await _repository.getFiles(_storageRepository.getDeviceId()!);
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
      return [];
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return [];
    }
  }
}
