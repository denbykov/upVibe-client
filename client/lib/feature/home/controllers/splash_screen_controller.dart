import 'package:get/get.dart';

import 'package:client/core/routes.dart';
import 'package:client/core/background_tasks.dart' as background_tasks;
import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/repositories/assets_repository.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class SplashScreenController extends GetxController {
  final AssetsRepository _assetsRepository = Get.find<AssetsRepository>();

  Future<void> initialize() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await _assetsRepository.loadAssets();

    await background_tasks.initialize();
    SynchronizationService().start();

    Get.offAndToNamed(Routes.home);
  }
}
