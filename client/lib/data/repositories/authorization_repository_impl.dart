import 'package:client/data/dto/tokens_dto.dart';
import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';
import 'package:client/data/local/storage_local_datasource.dart';
import 'package:client/exceptions/login_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uuid/uuid.dart';

import 'package:get/get.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _authDatasource =
      Get.find<AuthorizationRemoteDatasource>();

  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  final StorageLocalDatasource _storageDatasource =
      Get.find<StorageLocalDatasource>();

  TokensDTO? tokens;

  Future<String> registerDevice() async {
    var uuid = const Uuid();
    var myUuid = uuid.v4();
    var name = await _storageDatasource.getDeviceName();
    await _upvibeDatasource.registerDevice(myUuid, name);
    return myUuid;
  }

  @override
  Future<void> ensureDeviceRegistration() async {
    var deviceId = _storageDatasource.getUuid();
    if (deviceId == null) {
      deviceId = await registerDevice();
      await _storageDatasource.storeUuid(deviceId);
    }
  }

  @override
  Future<void> login() async {
    tokens ??= await _storageDatasource.getTokens();

    if (tokens == null) {
      tokens = await _authDatasource.login();
      await _storageDatasource.storeTokens(tokens!);
    }

    Map<String, dynamic> decodedAccessToken =
        JwtDecoder.decode(tokens!.accessToken);
    if (decodedAccessToken['exp'] * 1000 <
        (DateTime.now().millisecondsSinceEpoch - 5000)) {
      try {
        tokens = await _authDatasource.refreshToken(tokens!.refreshToken);
        await _storageDatasource.storeTokens(tokens!);
      } on LoginFailure catch (e) {
        if (e.type == LoginFailureType.invalidRefreshToken) {
          tokens = await _authDatasource.login();
          await _storageDatasource.storeTokens(tokens!);
        } else {
          rethrow;
        }
      }
    }

    if (kDebugMode) {
      debugPrint('Access token: ${tokens!.accessToken}');
    }

    _upvibeDatasource.setAccessToken(tokens!.accessToken);
  }

  @override
  Future<void> logout() async {
    _authDatasource.logout();
  }
}
