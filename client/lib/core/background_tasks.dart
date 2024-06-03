import 'dart:async';
import 'dart:io';

import 'package:client/core/bindings/home_binding.dart';
import 'package:client/core/constants.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/domain/use_cases/syncronization_use_case.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

const syncrhonizationTask = "syncrhonizationTask";

const synchronizationInterval = Duration(minutes: 15);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  HttpOverrides.global = MyHttpOverrides();

  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == syncrhonizationTask) {
        return await _synchronizationTask();
      }
      debugPrint('Unknown task: $task');
      return Future.value(false);
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(false);
    }
  });
}

Future<bool> _synchronizationTask() async {
  try {
    HomeBinding().dependencies();

    final storageRepository = Get.find<StorageRepository>();
    await storageRepository.ensureInitialized();

    final lastSyncrhonizationTime = storageRepository.getLastSynchronization();

    if (lastSyncrhonizationTime != null &&
        DateTime.now().difference(lastSyncrhonizationTime).inMinutes <
            synchronizationInterval.inMinutes) {
      return true;
    }

    final useCase = Get.find<SynchronizationUseCase>();
    // ignore: unused_local_variable
    final synchronizationReport = await useCase.synchronize();
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<void> initialize() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: NotificationChannels.defaultChannel,
        channelName: 'Basic notifications',
        channelDescription: 'Main notification channel',
        defaultColor: const Color(0xFF9D50DD),
        playSound: false,
      )
    ],
  );

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager().cancelAll();

  Workmanager().registerPeriodicTask(
    syncrhonizationTask,
    syncrhonizationTask,
    initialDelay: synchronizationInterval,
    frequency: synchronizationInterval,
    existingWorkPolicy: ExistingWorkPolicy.update,
  );
}
