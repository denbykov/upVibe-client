import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';
import 'package:client/data/local/storage_local_datasource.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _authDatasource =
      Get.find<AuthorizationRemoteDatasource>();

  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final StorageLocalDatasource _storageDatasource =
      Get.find<StorageLocalDatasource>();

  @override
  Future<void> login() async {
    if (kReleaseMode) {
      var token = await _authDatasource.login();
      _upvibeDatasource.setAccessToken(token);
      await _upvibeDatasource.testConnection();
    } else {
      var token = _storageDatasource.getDebugAccessToken();
      if (token != null) {
        _upvibeDatasource.setAccessToken(token);
        await _upvibeDatasource.testConnection();
      } else {
        var token = await _authDatasource.login();
        _upvibeDatasource.setAccessToken(token);
        await _upvibeDatasource.testConnection();
        await _storageDatasource.storeDebugAccessToken(token);
      }
    }
  }

  @override
  Future<void> logout() async {
    _authDatasource.logout();
  }
}
