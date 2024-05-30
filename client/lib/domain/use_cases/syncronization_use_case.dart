import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:client/core/constants.dart';
import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/local_file.dart';
import 'package:client/domain/entities/synchronization_report.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class SynchronizationUseCase {
  final StorageRepository _storageRepository = Get.find<StorageRepository>();
  final FileRepository _fileRepository = Get.find<FileRepository>();

  Future<SynchronizationReport> synchronize() async {
    final report = SynchronizationReport();

    final newFiles = await _fileRepository.getFiles(
      _storageRepository.getDeviceId()!,
      statuses: ['C'],
      isSynronized: false,
    );

    if (newFiles.isEmpty) {
      return report;
    }

    report.total = newFiles.length;

    await _showStatusNotification(report);

    for (final file in newFiles) {
      try {
        debugPrint('Synchronizing file ${file.id}');
        await _saveFile(file);
        report.synchronizedFiles.add(file.id);
      } catch (e) {
        debugPrint(e.toString());
        report.failedFiles.add(file.id);
      }

      await _showStatusNotification(report, done: true);
    }

    return report;
  }

  Future<void> _saveFile(File file) async {
    final binaryFile = await _fileRepository.downloadFile(file.id);

    final defaultFilePath = _storageRepository.getDefaultFilePath();

    final LocalFile localFile = LocalFile(
      id: '0',
      remoteId: file.id,
      path: path.join(defaultFilePath!, binaryFile.name),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _fileRepository.upsertFile(localFile);

    await _storageRepository.saveFile(binaryFile, defaultFilePath);

    await _fileRepository.confirmFile(
        file.id, _storageRepository.getDeviceId()!);
  }

  Future<void> _showStatusNotification(SynchronizationReport report,
      {bool done = false}) async {
    String ending = done ? 'Done' : 'In progress...';

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: NotificationChannels.defaultChannel,
          title: 'Syncrhonization',
          body:
              '🔍 Found: ${report.total} new files.<br>✅ Synchronized: ${report.synchronizedFiles.length} files.<br>❌ Failed: ${report.failedFiles.length} files.<br>$ending',
          notificationLayout: NotificationLayout.BigText),
    );
  }
}
