import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';
import 'package:client/data/local/storage_local_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:dio/dio.dart';

import 'package:get/get.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _authDatasource =
      Get.find<AuthorizationRemoteDatasource>();

  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final StorageLocalDatasource _storageDatasource =
      Get.find<StorageLocalDatasource>();

  Future<String> registerDevice() async {
    var uuid = const Uuid();
    var myUuid = uuid.v4();
    var name = await _storageDatasource.getDeviceName();
    await _upvibeDatasource.registerDevice(myUuid, name);
    return myUuid;
  }

  @override
  Future<void> login() async {
    if (kReleaseMode) {
      var token = await _authDatasource.login();
      _upvibeDatasource.setAccessToken(token);
      await _upvibeDatasource.testConnection();
    } else {
      var token = _storageDatasource.getDebugAccessToken();

      if (token != null) {
        try {
          _upvibeDatasource.setAccessToken(token);
          await _upvibeDatasource.testConnection();
          debugPrint(token);
          return;
        } on DioException catch (ex) {
          if (ex.type != DioExceptionType.badResponse) {
            rethrow;
          }
        }
      }

      token = await _authDatasource.login();

      debugPrint(token);
      _upvibeDatasource.setAccessToken(token);

      var myUuid = await registerDevice();
      await _storageDatasource.storeUuid(myUuid);

      if (_storageDatasource.getUuid() == null) {
        var myUuid = await registerDevice();
        await _storageDatasource.storeUuid(myUuid);
      }

      await _upvibeDatasource.testConnection();
      await _storageDatasource.storeDebugAccessToken(token);
    }
  }

  @override
  Future<void> logout() async {
    _authDatasource.logout();
  }
}
