import 'package:client/core/services/synchronization_service.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onHidden() async {
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
    SynchronizationService().start();
  }
}
