import 'dart:async';

import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/entities/synchronization_report.dart';
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

  final files = Rxn<List<File>>();

  StreamSubscription<SynchronizationReport>? _synchronizationSubscription;

  @override
  void onInit() async {
    super.onInit();

    files.value = await getFiles();

    _synchronizationSubscription = SynchronizationService().stream.listen(
      (SynchronizationReport data) async {
        try {
          if (data.total > 0) {
            files.value = await getFiles();
          }
        } catch (e) {
          debugPrint('Someting went wrong: $e');
        }
      },
    );
  }

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

  void stop() {
    _synchronizationSubscription?.cancel();
  }
}
