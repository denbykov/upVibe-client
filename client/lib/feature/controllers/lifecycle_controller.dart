import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();

  @override
  void onInit() async {
    super.onInit();
    await _storageRepository.ensureInitialized();
    await _storageRepository.setAppStatus(true);
  }

  @override
  void onHidden() async {
    debugPrint('App is hidden');
    await _storageRepository.ensureInitialized();
    await _storageRepository.setAppStatus(false);
    SynchronizationService().stop();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() async {
    debugPrint('App is resumed');
    await _storageRepository.ensureInitialized();
    await _storageRepository.setAppStatus(true);
    SynchronizationService().start();
  }
}
