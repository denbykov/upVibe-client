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
  Future<void> donwloadIconBySourceId(int id) async {
    final path = await _storageDatasource.getIconPathBySourceId(id);
    await _upvibeDatasource.downloadIconBySourceId(id, path);
  }

  @override
  Future<SvgPicture> getIconBySourceId(int id) async {
    return await _storageDatasource.getIconBySourceId(id);
  }
}
