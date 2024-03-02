import 'package:get/get.dart';

import 'package:client/feature/home/controllers/home_controller.dart';
import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/domain/use_cases/login_use_case.dart';
import 'package:client/data/repositories/authorization_repository_impl.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorizationRemoteDatasource>(
        () => AuthorizationRemoteDatasource());
    Get.lazyPut<AuthorizationRepository>(() => AuthorizationRepositoryImpl());
    Get.lazyPut<LoginUseCase>(() => LoginUseCase());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
