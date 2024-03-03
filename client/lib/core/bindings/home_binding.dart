import 'package:get/get.dart';

import 'package:client/feature/home/controllers/login_controller.dart';
import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/domain/use_cases/login_use_case.dart';
import 'package:client/data/repositories/authorization_repository_impl.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthorizationRemoteDatasource>(
      AuthorizationRemoteDatasource(),
      permanent: true,
    );

    Get.put<UpvibeRemoteDatasource>(
      UpvibeRemoteDatasource(),
      permanent: true,
    );

    Get.lazyPut<AuthorizationRepository>(() => AuthorizationRepositoryImpl());
    Get.lazyPut<LoginUseCase>(() => LoginUseCase());

    Get.lazyPut<SnackBarController>(() => SnackBarController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
