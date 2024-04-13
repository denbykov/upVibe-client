import 'package:client/domain/repositories/assets_repository.dart';

import 'package:client/data/remote/upvibe_remote_datasource.dart';
import 'package:client/data/local/storage_local_datasource.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class AssetsRepositoryImpl extends AssetsRepository {
  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final StorageLocalDatasource _storageDatasource =
      Get.find<StorageLocalDatasource>();

  @override
  Future<void> loadAssets() async {
    final sources = await _upvibeDatasource.getSources();
    for (final source in sources) {
      final logo = await _upvibeDatasource.getSourceLogo(source.id);
      await _storageDatasource.cacheSourceLogo(source.id, logo);
    }
  }

  @override
  SvgPicture getIconBySourceId(String id) {
    return _storageDatasource.getIconBySourceId(id);
  }
}
