import 'dart:async';

import 'package:get/get.dart';

import 'package:client/domain/use_cases/syncronization_use_case.dart';
import 'package:client/domain/entities/synchronization_report.dart';

class SynchronizationService {
  static final SynchronizationService _instance =
      SynchronizationService._internal();
  factory SynchronizationService() => _instance;

  final useCase = Get.find<SynchronizationUseCase>();

  final StreamController<SynchronizationReport> _controller =
      StreamController<SynchronizationReport>.broadcast();
  Timer? _timer;

  SynchronizationService._internal();

  bool syncInProgress = false;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      if (syncInProgress) {
        return;
      }

      syncInProgress = true;
      await _synchronize();
      syncInProgress = false;
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _synchronize() async {
    final data = await useCase.synchronize();
    _controller.add(data);
  }

  Stream<SynchronizationReport> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
