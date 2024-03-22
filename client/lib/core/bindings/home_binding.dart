import 'package:client/data/repositories/assets_repository_impl.dart';
import 'package:client/domain/repositories/assets_repository.dart';
import 'package:client/feature/controllers/assets_controller.dart';
import 'package:client/feature/file/controllers/file_controller.dart';
import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

import 'package:client/feature/home/controllers/splash_screen_controller.dart';
import 'package:client/feature/home/controllers/login_controller.dart';
import 'package:client/feature/home/controllers/home_drawer_controller.dart';
import 'package:client/feature/home/controllers/settings_controller.dart';
import 'package:client/feature/home/controllers/home_controller.dart';
import 'package:client/feature/home/controllers/add_controller.dart';

import 'package:client/feature/file/controllers/add_file_controller.dart';
import 'package:client/feature/file/controllers/files_controller.dart';
import 'package:client/feature/file/controllers/file_list_item_controller.dart';

import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/domain/repositories/file_repository.dart';

import 'package:client/domain/use_cases/login_use_case.dart';

import 'package:client/data/repositories/authorization_repository_impl.dart';
import 'package:client/data/repositories/storage_repository_impl.dart';
import 'package:client/data/repositories/file_repository_impl.dart';

import 'package:client/data/local/storage_local_datasource.dart';

import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StorageLocalDatasource>(
      StorageLocalDatasource(),
      permanent: true,
    );

    Get.put<AuthorizationRemoteDatasource>(
      AuthorizationRemoteDatasource(),
      permanent: true,
    );

    Get.put<UpvibeRemoteDatasource>(
      UpvibeRemoteDatasource(),
      permanent: true,
    );

    Get.lazyPut<AuthorizationRepository>(() => AuthorizationRepositoryImpl());
    Get.lazyPut<StorageRepository>(() => StorageRepositoryImpl());
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl());
    Get.lazyPut<AssetsRepository>(() => AssetsRepositoryImpl());

    Get.lazyPut<LoginUseCase>(() => LoginUseCase());

    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<AssetsController>(() => AssetsController());
    Get.lazyPut<SnackBarController>(() => SnackBarController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeDrawerController>(() => HomeDrawerController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<AddController>(() => AddController());

    Get.lazyPut<AddFileController>(() => AddFileController());
    Get.lazyPut<FilesController>(() => FilesController());
    Get.lazyPut<FileListItemController>(() => FileListItemController());
    Get.lazyPut<FileController>(() => FileController());
  }
}
