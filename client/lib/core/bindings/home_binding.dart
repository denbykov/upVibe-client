import 'package:client/feature/controllers/lifecycle_controller.dart';

import 'package:client/data/repositories/assets_repository_impl.dart';
import 'package:client/data/repositories/tag_repository_impl.dart';
import 'package:client/domain/repositories/assets_repository.dart';
import 'package:client/domain/repositories/tag_repository.dart';
import 'package:client/feature/controllers/source_icon_controller.dart';
import 'package:client/feature/file/controllers/file_controller.dart';
import 'package:client/feature/file/controllers/playlist_controller.dart';
import 'package:client/feature/file/controllers/playlists_controller.dart';
import 'package:client/feature/home/controllers/mapping_priority_controller.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/splash_screen_controller.dart';
import 'package:client/feature/home/controllers/login_controller.dart';
import 'package:client/feature/home/controllers/home_drawer_controller.dart';
import 'package:client/feature/home/controllers/settings_controller.dart';
import 'package:client/feature/home/controllers/home_controller.dart';
import 'package:client/feature/home/controllers/add_controller.dart';

import 'package:client/feature/file/controllers/add_file_controller.dart';
import 'package:client/feature/file/controllers/add_playlist_controller.dart';
import 'package:client/feature/file/controllers/files_controller.dart';
import 'package:client/feature/file/controllers/file_list_item_controller.dart';
import 'package:client/feature/file/controllers/playlist_list_item_controller.dart';

import 'package:client/domain/use_cases/syncronization_use_case.dart';

import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/domain/repositories/storage_repository.dart';
import 'package:client/domain/repositories/file_repository.dart';
import 'package:client/domain/repositories/playlist_repository.dart';

import 'package:client/data/repositories/authorization_repository_impl.dart';
import 'package:client/data/repositories/storage_repository_impl.dart';
import 'package:client/data/repositories/file_repository_impl.dart';
import 'package:client/data/repositories/playlist_repository_impl.dart';

import 'package:client/data/local/storage_local_datasource.dart';
import 'package:client/data/local/upvibe_local_datasource.dart';

import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StorageLocalDatasource>(
      StorageLocalDatasource(),
      permanent: true,
    );

    Get.put<UpvibeLocalDatasource>(
      UpvibeLocalDatasource(),
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

    Get.put<AuthorizationRepository>(
      AuthorizationRepositoryImpl(),
      permanent: true,
    );

    Get.put<StorageRepository>(
      StorageRepositoryImpl(),
      permanent: true,
    );

    Get.lazyPut<FileRepository>(() => FileRepositoryImpl());
    Get.lazyPut<PlaylistRepository>(() => PlaylistRepositoryImpl());
    Get.lazyPut<AssetsRepository>(() => AssetsRepositoryImpl());
    Get.lazyPut<TagRepository>(() => TagRepositoryImpl());

    Get.lazyPut<SynchronizationUseCase>(() => SynchronizationUseCase());

    Get.put(LifeCycleController());

    Get.lazyPut<SplashScreenController>(() => SplashScreenController());

    Get.create<SourceIconController>(() => SourceIconController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeDrawerController>(() => HomeDrawerController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<MappingPriorityController>(() => MappingPriorityController());
    Get.lazyPut<AddController>(() => AddController());

    Get.lazyPut<AddFileController>(() => AddFileController());
    Get.lazyPut<AddPlaylistController>(() => AddPlaylistController());
    Get.lazyPut<FilesController>(() => FilesController());
    Get.lazyPut<FileListItemController>(() => FileListItemController());
    Get.lazyPut<PlaylistListItemController>(() => PlaylistListItemController());
    Get.lazyPut<FileController>(() => FileController());
    Get.lazyPut<PlaylistsController>(() => PlaylistsController());
    Get.lazyPut<PlaylistController>(() => PlaylistController());
  }
}
